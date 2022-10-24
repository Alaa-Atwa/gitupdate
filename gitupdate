#!/bin/bash
# this code automate syncing github repos

read -p " Files to Add,[. for all] :  " files

if [[ -z "$files" ]];then
    echo "You must provide FileNames or . for all files "
    exit 0
fi

if [[ ! -d "./.git" ]];then
    git init
fi

git add $files
if [[ $? == 0 ]];then
  read -p "commit message: " message
  git commit -m "$message"
  git push origin main
else
  echo "Error Updating "
fi
