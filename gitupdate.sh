#!/bin/bash
# this code automate uploading to github 

# functions 
function gitInit(){
    # check if git is already initialized in the currrent directory 
    if [[ ! -d "./.git" ]]; then
         git init
    fi

    # adding files to staging area 
    read -ep " Type File Names to commit,[type \".\" for all files] : " files
    if [[ -z "$files" ]]; then
         echo "You must provide FileNames or . for all files "
        exit 0
    fi

    git add $files

    # commit files to staging area 
    if [[ $? == 0 ]];then
        read -ep "commit message: " message
        git commit -m "$message"
    else 
        echo "Error Adding file/s"
    fi
}

# ask to create a new repo on github from terminal:
read -ep "Do You Want To Create A New Repo On Github,[y|n]:  " ans

case $ans in
  Y|y)
      if [[ `command -v gh` ]]; then
          read -ep "Enter the new repo name: " newRepo
          gh auth login
          gitInit
          read -ep "Do you want the repo to be public or private, [ public | private ] : " check
          gh repo create "$newRepo" --"$check" --source=. --remote=upstream --push
      else 
          echo "you must install gh first to create a new repo"
          echo "link to install: https://snapcraft.io/gh"
          exit 1
      fi 
      ;;
  N|n)
      echo " Ok!, adding to an existing repo  " 
      read -ep "Enter your userName on github: " userName
      read -ep "Enter RepoName on github: " repoName

      gitInit
      git remote add origin https://github.com/"$userName"/"$repoName".git
      git push -u origin main
      ;;
  *)
      echo -n "Please Enter A valid answer" 
      ;;
esac
