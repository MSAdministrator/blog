#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Ensure public submodule is on master branch
cd public
git checkout master
git pull origin master
cd ..

# Build the project (using Hugo modules for v4 theme)
hugo

# Run Pagefind to index the site for search
echo -e "\033[0;32mIndexing site with Pagefind...\033[0m"
npx -y pagefind --site public

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

# Commit changes to the main blog repo
echo -e "\033[0;32mCommitting changes to blog repo...\033[0m"
git add .
git commit -m "$msg"
git push origin master
