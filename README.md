# Uploading files from local folder to Github

Create .gitignore file in local folder: https://help.github.com/en/github/using-git/ignoring-files<br/>
<br/>
Upload files using command line (https://lab.github.com/githubtraining/uploading-your-project-to-github):
1. In your command line, navigate to your project directory: `cd folderpath`
2. Type `git init` to initialize the directory as a Git repository
2. Type `git remote add origin https://github.com/melaniesgonzalez/github-upload.git`
3. Type `git add .`
4. Type `git commit -m "initializing repository"`
5. Type `git push -u origin master` to push the files you have locally to the remote on GitHub. (You may be asked to log in.)
