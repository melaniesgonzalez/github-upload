# Uploading files from local repo to remote repo

Create .gitignore file in local repository using command line (https://help.github.com/en/github/using-git/ignoring-files)
1. In Terminal, navigate to your project directory: `cd folderpath`
2. Type `touch .gitignore`
3. Type `ls -a` to see new contents of directory

Initialize repository using command line (https://lab.github.com/githubtraining/uploading-your-project-to-github):
1. In Terminal, navigate to your project directory: `cd folderpath`
2. Type `git init` to initialize the directory as a Git repository
2. Type `git remote add origin https://github.com/melaniesgonzalez/github-upload.git` to add remote repo called origin at the given URL
3. Type `git add .` to add local repo to staging area
4. Type `git commit -m "initializing repository"` to commit to local repo with a message brief summary of changes being committed
5. Type `git push -u origin master` to push local repo to remote repo (sometimes asked to log in)
6. Type `ls -a` to see new contents of project directory

Commit file to local repo using command line:
1. In Terminal, navigate to your project directory: `cd folderpath`
2. Type `git status` to see status of current branch (says *nothing to commit, working tree clean*)
3. Type `touch index.html` to add empty html file called *index* to directory
4. Type `ls -a` to see new contents of directory (now includes *index.html*)
5. Type `git status` to see status of current branch (now lists *index.html* under *Untracked files*)
6. Type `git add index.html` to add *index.html* to staging area
7. Type `git status` to see status of current branch (now lists *index.html* under *Changes to be committed*)
8. Type `git commit -m "Create index.html"` to commit *index.html* file to local repo with a message brief summary of changes being committed
9. Type `git status` to see status of current branch (now says *current branch is ahead of 'origin/master' by 1 commit*, but otherwise *nothing to commit, working tree clean*)
10. Type `git log` to view log of previous commits on branch

# Merge local and remote repositories
Pull and push commits from and to remote repo (merge method)
1. **FALSE START** Type `git push` to push local changes to remote repo (*Error: failure to push some refs to Github*; *hint: Updates were rejected because the remote contains work that you do not have locally. This is usually caused by another repository pushing to the same ref. You may want to first integrate the remote changes before pushing again.*)
2. Type `git pull` to pull changes from remote repo
3. Type `git merge` to merge remote repo into local branch
   1. Default editor on my Mac is VIM; generates this message: *Please enter a commit message to explain why this merge is necessary, especially if it merges an updated upstream into a topic branch* 
      1. Press `i` [for Insert]
      2. Write merge message (e.g., `To merge local and Github changes`)
      3. Press `ecs` [to Escape message]
      4. Write `:wq` [to Write message, and then Quit]
      5. Press `return`
4. Type `git status` to see status of current branch (now says *branch is ahead of 'origin/master' by 2 commits* (local and pulled/merged), but otherwise *nothing to commit, working tree clean*)
5. Type `git push` to push changes to remote
6. Type `git status` to see status of current branch (says *nothing to commit, working tree clean*)

Pull and push commits from and to remote repo (rebase method) (https://www.derekgourlay.com/blog/git-when-to-merge-vs-when-to-rebase/)
