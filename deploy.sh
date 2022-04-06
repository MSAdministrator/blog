#!/bin/bash

if python3 -c 'import pkgutil; exit(not pkgutil.find_loader("algoliasearch"))'; then
  echo "algoliasearch found"
else
  python3 -m pip install -r requirements.txt
fi

#python3 -m ./algolia.py

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo -t bilberry-hugo-theme

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd ..
