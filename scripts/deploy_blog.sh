#! /usr/bin/env bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
hugo -t even

cd public
git add .

msg="rebuilding site `date`"
if [ $# -eq 1 ]; then
    msg="$1"
fi

git commit -m "$msg"
git push origin master

cd ..
git add .
git commit -m "$msg"
git push origin master
