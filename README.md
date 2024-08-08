# Base QA Automation

# About

This project was made to speed up the process of creating a new api or front-end automation repository.
It includes necessary files, drivers, and a standardized folder structure.

# Setup
There are two ways to use this template.

1. Via Github web. (Recommended)

During the creation of a new repository in github, select **base-qa-automation** as template. 
![image](https://github.com/user-attachments/assets/df8aa3a2-fbb4-470e-af14-4a7ae10b31f6)
![image](https://github.com/user-attachments/assets/e20ea183-e41c-4438-84c8-6b8a0ba5f3be)

2. Via Git terminal.

A repository is already created without any template.

  a. In terminal, clone the **base-qa-automation** repository using git clone _repo_url_
  
  b. Create new repository in github
  
  c. Open the cloned base-qa-automation repo in VSCode or any code editor

  d. Open terminal of base-qa-automation repository

  e. Run **git remote remove origin**. This removes the remote and its references from your local repository.

  f. Run **git remote add origin _repo_url_**. This adds a remote repository to your local Git repository.

  g. Run **git checkout -b development**. Creates the base branch - development.

  h. Run **git push --set-upstream origin development**. This pushes the contents of base-qa-automation repository to you created repository.
