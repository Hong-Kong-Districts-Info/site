git remote set-url origin git@github.com:Hong-Kong-Districts-Info/site.git

git pull https://github.com/Hong-Kong-Districts-Info/site.git master

git commit -a -m "update site" 

# Push source and build repos.
git push origin master

$SHELL