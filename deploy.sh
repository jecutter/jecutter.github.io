#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

msg="Rebuilding site: `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi

# Build Jekyll site
JEKYLL_ENV=production bundle exec jekyll build

# Sync built Jekyll _site/ files to public Github repo
rsync -Pav _site/ public/ --exclude="public/"

# Commit changes to the root project folder
git add .
git commit -m "$msg"

# Go To Public folder
cd public
# Add changes to git.
git add .
# Commit changes.
git commit -m "$msg"

# Push source and build repos.
git push -u origin master

# Come Back up to the Project Root
cd ..
