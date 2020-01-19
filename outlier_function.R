####Function to cap outliers at next non-outlier value ----
capOutlier <- function(x){
  qnt <- quantile(x, probs=c(.25, .75), na.rm = T)
  #caps <- quantile(x, probs=c(.05, .95), na.rm = T)
  caps <- boxplot.stats(x)$stats
  H <- 1.5 * IQR(x, na.rm = T)
  x[x < (qnt[1] - H)] <- caps[1]
  x[x > (qnt[2] + H)] <- caps[5]
  return(x)
}

#### Winsorize outliers ----
####*Function for standardizing variables ----
standardize <- function (x, centerFun = mean, scaleFun = sd) {
  if (is.null(dim(x))) {
    center <- centerFun(x)
    x <- x - center
    if (identical(centerFun, mean) && identical(scaleFun, 
                                                sd)) {
      scale <- sqrt(sum(x^2)/max(1, length(x) - 1))
    }
    else if (identical(centerFun, median) && identical(scaleFun, 
                                                       mad)) {
      scale <- mad(x, center = 0)
    }
    else scale <- scaleFun(x)
    x <- x/scale
  }
  else {
    if (identical(centerFun, mean)) {
      center <- colMeans(x)
    }
    else center <- apply(x, 2, centerFun)
    x <- sweep(x, 2, center, check.margin = FALSE)
    if (identical(centerFun, mean) && identical(scaleFun, 
                                                sd)) {
      f <- function(v) sqrt(sum(v^2)/max(1, length(v) - 
                                           1))
      scale <- apply(x, 2, f)
    }
    else if (identical(centerFun, median) && identical(scaleFun, 
                                                       mad)) {
      scale <- apply(x, 2, mad, center = 0)
    }
    else scale <- apply(x, 2, scaleFun)
    x <- sweep(x, 2, scale, "/", check.margin = FALSE)
  }
  attr(x, "center") <- center
  attr(x, "scale") <- scale
  x
}

####*Function to robustly standardize variables using median and MAD----
robStandardize <- function (x, centerFun = median, scaleFun = mad, fallback = FALSE, eps = .Machine$double.eps, ...) {
  xs <- standardize(x, centerFun = centerFun, scaleFun = scaleFun)
  if (isTRUE(fallback)) {
    scale <- attr(xs, "scale")
    if (is.null(dim(x))) {
      if (scale <= eps) 
        xs <- standardize(x)
    }
    else {
      tooSmall <- which(scale <= eps)
      if (length(tooSmall) > 0) {
        center <- attr(xs, "center")
        xcs <- standardize(x[, tooSmall])
        center[tooSmall] <- attr(xcs, "center")
        scale[tooSmall] <- attr(xcs, "scale")
        xs[, tooSmall] <- xcs
        attr(xs, "center") <- center
        attr(xs, "scale") <- scale
      }
    }
  }
  xs
}

####*Function to winsorize single variables after robust standardization----
#weights points such that outliers shrink into
winsorize.uni <- function (x, standardized = FALSE, centerFun = median, scaleFun = mad, const = 3.84, return = c("data", "weights"), ...) {
  require(robustHD)
  standardized <- isTRUE(standardized)
  if (standardized) 
    return <- match.arg(return)
  else {
    x <- robStandardize(x, centerFun = centerFun, scaleFun = scaleFun, 
                        ...)
    center <- attr(x, "center")
    scale <- attr(x, "scale")
  }
  weights <- pmin(const/abs(x), 1) # calculate weights
  if (standardized && return == "weights") 
    return(weights)
  x <- weights * x # apply weights
  if (!standardized) {
    x <- c(x * scale + center) # transform back to original scale
  }
  x
}

####*Function to winsorize bivariate relationships following robust standardization----
winsorize.multi <- function (x, standardized = FALSE, centerFun = median, scaleFun = mad, const = 2, prob = 0.95, tol = .Machine$double.eps^0.5, return = c("data", "weights"), ...) {
  require(robustHD)
  x <- as.matrix(x)
  m <- ncol(x)
  standardized <- isTRUE(standardized)
  if (standardized) 
    return <- match.arg(return)
  if (m == 1) {
    attributes <- attributes(x)
    x <- winsorize(c(x), standardized = standardized, centerFun = centerFun, 
                   scaleFun = scaleFun, const = const, return = return, 
                   ...)
    if (!(standardized && return == "weights")) 
      attributes(x) <- attributes
  }
  else {
    if (nrow(x) <= m) {
      stop("not enough observations for inversion of correlation matrix")
    }
    if (!standardized) {
      attributes <- attributes(x)
      x <- robStandardize(x, centerFun = centerFun, scaleFun = scaleFun, 
                          ...)
      center <- attr(x, "center")
      scale <- attr(x, "scale")
    }
    R <- .Call("R_corMatHuber", R_x = x, R_c = const, R_prob = prob, 
               R_tol = tol, PACKAGE = "robustHD")
    eig <- eigen(R, symmetric = TRUE)
    if (eig$values[m] < 0) {
      Q <- eig$vectors
      lambda <- apply(x %*% Q, 2, scaleFun)^2
      R <- Q %*% diag(lambda) %*% t(Q)
    }
    invR <- solve(R)
    md <- rowSums((x %*% invR) * x)
    d <- qchisq(prob, df = m)
    weights <- pmin(sqrt(d/md), 1)
    if (standardized && return == "weights") 
      return(weights)
    x <- weights * x
    if (!standardized) {
      x <- sweep(x, 2, scale, "*", check.margin = FALSE)
      x <- sweep(x, 2, center, "+", check.margin = FALSE)
      attributes(x) <- attributes
    }
  }
  x
}

corHuberfix <- function (x, y, type = c("bivariate", "adjusted", "univariate"), standardized = FALSE, centerFun = median, scaleFun = mad, const = 2, prob = 0.95, tol = .Machine$double.eps^0.5, ...) {
  n <- length(x)
  if (length(y) != n) 
    stop("'x' and 'y' must have the same length")
  if (n == 0) 
    return(NA)
  type <- match.arg(type)
  if (!isTRUE(standardized)) {
    x <- robStandardize(x, centerFun = centerFun, scaleFun = scaleFun, 
                        ...)
    y <- robStandardize(y, centerFun = centerFun, scaleFun = scaleFun, 
                        ...)
  }
  switch(type, 
         bivariate = corHuberBi(x, y, const = const, prob = prob, tol = tol),
         adjusted = corHuberAdj(x, y, const = const), 
         univariate = corHuberUni(x, y, const = const))
}

####*Function to compared methods for handling outliers----
comparemethods <- function(xvar, yvar, both = TRUE, single = c("x", "y"), cap = FALSE, win = FALSE){
  
  xvar.o = capOutlier(xvar)
  xvar.w = winsorize.uni(xvar)
  yvar.o = capOutlier(yvar)
  yvar.w = winsorize.uni(yvar)
  
  bothraw = cor.test(xvar, yvar)
  bothcap = cor.test(xvar.o, yvar.o)
  bothwin = cor.test(xvar.w, yvar.w)
  xcapyraw = cor.test(xvar.o, yvar)
  xwinyraw = cor.test(xvar.w, yvar)
  xrawycap = cor.test(xvar, yvar.o)
  xrawywin = cor.test(xvar, yvar.w)
  
  if(both == T & cap == F & win == F){
    print(paste("Both raw:" , "r = ", round(bothraw[[4]], 2) , ", p = ", round(bothraw[[3]], 2)))
  } else if(both == T & cap == T & win == F){
    print(paste("Both capped:" , "r = ", round(bothcap[[4]], 2) , ", p = ", round(bothcap[[3]], 2)))
  } else if(both == T & cap == F & win == T){
    print(paste("Both winzorized:" , "r = ", round(bothwin[[4]], 2) , ", p = ", round(bothwin[[3]], 2)))
  } else if(both == F & single == "x" & cap == T & win == F) {
    print(paste("X capped:", "r = ", round(xcapyraw[[4]], 2) , ", p = ", round(xcapyraw[[3]], 2)))
  } else if(both == F & single == "x" & cap == F & win == T) {
    print(paste("X winzorized:", "r = ", round(xwinyraw[[4]], 2) , ", p = ", round(xwinyraw[[3]], 2)))
  } else if(both == F & single == "y" & cap == T & win == F) {
    print(paste("Y capped:", "r = ", round(xrawycap[[4]], 2) , ", p = ", round(xrawycap[[3]], 2)))
  } else if(both == F & single == "y" & cap == F & win == T) {
    print(paste("Y winzorized:", "r = ", round(xrawywin[[4]], 2) , ", p = ", round(xrawywin[[3]], 2)))
  } else print("Combination not permissible") 
}


