Set Username and User Email using command line
1. Type `git congif --global user.name "<username>"`
2. Type `git congif --global user.email "<useremail>"`

# Uploading files from local repo to remote repo

Create .gitignore file in local repository using command line (https://help.github.com/en/github/using-git/ignoring-files):
1. In Terminal, navigate to your project directory: `cd <folderpath>`
2. Type `touch .gitignore`
3. Type `ls -a` to see new contents of directory

Initialize local and remote repositories using command line (https://lab.github.com/githubtraining/uploading-your-project-to-github):
1. In Terminal, navigate to your project directory: `cd <folderpath>`
2. Type `git init` to initialize the directory as a Git repository
2. Type `git remote add origin https://github.com/melaniesgonzalez/<project name>.git` to create a remote repo called *origin* at the given URL with the given project name
3. Type `git add .` to add all files inside folder to local staging area for change tracking
4. Type `git commit -m "Initialize repository"` to commit staged files to local repo with a message brief summary of changes being committed
5. Type `git push -u origin master` to push local repo to remote repo (will sometimes be asked to log in)
6. Type `ls -a` to see new contents of project directory
7. Type `git log` to view commit history

Commit file to local repo using command line (https://www.notion.so/Introduction-to-Git-ac396a0697704709a12b6a0e545db049#5d881566c7e74a58830f944eacd57d3e):
1. In Terminal, navigate to your project directory: `cd <folderpath>`
2. Type `git status` to see status of current branch (says *Your branch is up to date with 'origin/master'* and *nothing to commit, working tree clean*)
3. Type `touch <filename>` to add file to local directory (e.g., *index.html*)
4. Type `ls -a` to see new contents of directory (now includes *<filename>*)
5. Type `git status` to see status of current branch (says *Your branch is up to date with 'origin/master'* but now lists *new file: <filename>* under *Untracked files*)
6. Type `git add <filename>` to add *<filename>* to staging area for change tracking
7. Type `git status` to see status of current branch (says *Your branch is up to date with 'origin/master'* but now lists *<filename>* under *Changes to be committed*)
8. Type `git commit -m "Create <filename>"` to commit *<filename>* file to local repo with a message brief summary of changes being committed
9. Type `git status` to see status of current branch (now says *current branch is ahead of 'origin/master' by 1 commit*, but otherwise *nothing to commit, working tree clean*)

# Merge local and remote repositories
Pull and push commits from and to remote repo (merge method) (https://stackoverflow.com/questions/19085807/please-enter-a-commit-message-to-explain-why-this-merge-is-necessary-especially):
1. **FALSE START** Type `git push` to push local changes to remote repo (*Error: failure to push some refs to Github*; *hint: Updates were rejected because the remote contains work that you do not have locally. This is usually caused by another repository pushing to the same ref. You may want to first integrate the remote changes before pushing again.*)
2. Type `git pull` to pull changes from remote repo and merge with local repo
   1. Generates this message (because default editor on Mac is VIM): *Please enter a commit message to explain why this merge is necessary, especially if it merges an updated upstream into a topic branch* 
      1. Press `i` [for Insert]
      2. Write merge message (e.g., `To merge local and Github changes`)
      3. Press `esc` [to Escape message]
      4. Write `:wq` [to Write message, and then Quit]
      5. Press `return`
3. Type `git status` to see status of current branch (now says *branch is ahead of 'origin/master' by 2 commits* (local and pulled/merged), but otherwise *nothing to commit, working tree clean*)
4. Type `git push` to push changes to remote repo
5. Type `git status` to see status of current branch (says *Your branch is up to date with 'origin/master'* and *nothing to commit, working tree clean*)

Pull and push commits from and to remote repo (rebase method) (https://www.derekgourlay.com/blog/git-when-to-merge-vs-when-to-rebase/):
1. TBD

# Edit Existing Repositories
Delete file(s) from repository using command line (https://stackoverflow.com/questions/29276283/remove-files-from-remote-branch-in-git):
1. Type `git pull` to pull changes from remote repo and merge with local repo
   1. Generates this message (because default editor on Mac is VIM): *Please enter a commit message to explain why this merge is necessary, especially if it merges an updated upstream into a topic branch* 
      1. Press `i` [for Insert]
      2. Write merge message (e.g., `To merge local and Github changes`)
      3. Press `esc` [to Escape message]
      4. Write `:wq` [to Write message, and then Quit]
      5. Press `return`
2. Type `git rm <filename1> <filename2>` to remove unwanted files
3. Type `git status` to see status of current branch (*Your branch is up to date with 'origin/master'* but now lists deleted files under *Changes to be committed*)
4. Type `git commit -m "Delete <filename1> <filename2> files"` to commit deletion of files to local repo with a message brief summary of changes being committed
5. Type `git status` to see status of current branch (now says *current branch is ahead of 'origin/master' by 1 commit*, but otherwise *nothing to commit, working tree clean*)
6. Type `git pull` to pull changes from remote repo
   1. Default editor on my Mac is VIM; generates this message: *Please enter a commit message to explain why this merge is necessary, especially if it merges an updated upstream into a topic branch* 
      1. Press `i` [for Insert]
      2. Write merge message (e.g., `To merge local and Github changes`)
      3. Press `ecs` [to Escape message]
      4. Write `:wq` [to Write message, and then Quit]
      5. Press `return`
3. Type `git status` to see status of current branch (now says *branch is ahead of 'origin/master' by 2 commits* (local and pulled/merged), but otherwise *nothing to commit, working tree clean*)
4. Type `git push` to push changes to remote repo
5. Type `git status` to see status of current branch (says *Your branch is up to date with 'origin/master'* and *nothing to commit, working tree clean*)

Unstage staged content
1. Type `git reset HEAD filename`
