#!/bin/bash

USER=reale
REPO=peppol.global
BRANCH=master

## update gh-pages
[[ -n $GIT_ACCESS_TOKEN ]] || { echo No GitHub access token found ; exit 1 ; }

git config --global user.email "roberto@reale.info"
git config --global user.name "Roberto Reale"
git config --global credential.helper store
echo "https://$GIT_ACCESS_TOKEN:x-oauth-basic@github.com" >> ~/.git-credentials

rm -fr /tmp/$REPO
cd /tmp
git clone https://github.com/$USER/$REPO.git
cd $REPO
git checkout $BRANCH || git checkout --orphan $BRANCH

## fetch news
cd _posts
python ../scripts/peppol-news.py --startdate $(date +%s)

git add -A
git commit -m "Update news" --allow-empty
git push origin $BRANCH
