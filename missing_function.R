describeMissing <- function(x, ...){
  
  require(psych)
  df = psych::describe(x, trim = 0, quant = c(.25, .75))
  
  require(magrittr)
  df2 = df %>%
    dplyr::select(n, min, Q0.25, median, mean, Q0.75, max, skew, kurtosis, sd) %>%
    mutate('NA' = sum(is.na(x))) %>%
    round(., 2)
  
  matrix <- c(n = df2[[1]], 
              min = df2[[2]], 
              Q1 = df2[[3]], 
              median = df2[[4]], 
              mean = df2[[5]], 
              Q3 = df2[[6]],
              max = df2[[7]], 
              skew = df2[[8]], 
              kurtosis = df2[[9]], 
              sd = df2[[10]], 
              'NA' = df2[[11]])
  
  matrix
}

describeMissingSummary <- function(x, ...){
  
  require(psych)
  df = psych::describe(x, trim = 0, quant = c(.25, .75))
  
  require(magrittr)
  df2 = df %>%
    dplyr::select(min, median, mean, max, sd) %>%
    mutate('NA' = sum(is.na(x))) %>%
    round(., 2)
  
  matrix <- c(min = df2[[1]], 
              median = df2[[2]], 
              mean = df2[[3]], 
              max = df2[[4]], 
              sd = df2[[5]], 
              na = df2[[6]])
  
  matrix
}

describeMissingSummaryAbbrev <- function(x, ...){
  
  require(psych)
  df = psych::describe(x, trim = 0, quant = c(.25, .75), IQR = TRUE)
  
  require(magrittr)
  df2 = df %>%
    dplyr::select(mean, median, IQR, sd) %>%
    mutate('NA' = sum(is.na(x))) %>%
    round(., 2)
  
  matrix <- c(mean = df2[[1]], 
              median = df2[[2]], 
              IQR = df2[[3]], 
              sd = df2[[4]], 
              na = df2[[5]])
  
  matrix
}


tableMissing <- function(data, xvar, ...){
  
  xvar2 = enquo(xvar)
  
  require(tidyverse)
  data %>%
    dplyr::group_by(!! xvar2) %>%
    summarize(n = n()) %>%
    mutate(prop = case_when(!is.na(!! xvar2) ~ n / sum(n[!is.na(!! xvar2)]),
                            is.na(!! xvar2) ~ NA_real_)) %>%
    mutate(propNA = case_when(is.na(!! xvar2) ~ n / sum(n),
                              !is.na(!! xvar2) ~ NA_real_)) %>%
    as.data.frame()
}