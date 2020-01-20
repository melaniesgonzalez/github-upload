# Uploading files from local folder to Github

Create .gitignore file in local folder (https://help.github.com/en/github/using-git/ignoring-files)
1. 
<br/>
Initialize repository using command line (https://lab.github.com/githubtraining/uploading-your-project-to-github):
1. In your command line, navigate to your project directory: `cd folderpath`
2. Type `git init` to initialize the directory as a Git repository
2. Type `git remote add origin https://github.com/melaniesgonzalez/github-upload.git`
3. Type `git add .`
4. Type `git commit -m "initializing repository"`
5. Type `git push -u origin master` to push the files you have locally to the remote on GitHub. (You may be asked to log in.)
6. Type `ls -a` to see new contents of directory
<br/>
Upload empty HTML file using command line
1. In your command line, navigate to your project directory: `cd folderpath`
2. Type `git status` to see status of current branch (likely says *nothing to commit, working tree clean*)
3. Type `touch index.html` to add empty html file called *index* to directory
4. Type `ls -a` to see new contents of directory (now includes *index.html*)
5. Type `git status` to see new contents of directory (now lists *index.html* under *Untracked files*)
6. Type `git add index.html` to commit *index.html* locally
7. Type `git status` to see status of current branch (now lists *index.html* under *Changes to be committed*)
8. Type `git commit -m "Create index.html"` to commit *index.html* file to repository with a message briefly summarizing the changes being committed using the present tense
9. Type `git status` to see status of current branch (now says my branch is ahead of 'origin/master' by 1 commit, but otherwise *nothing to commit, working tree clean*)
10. Type `git log` to view log of previous commits on branch
