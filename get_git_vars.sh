#!/bin/bash

PROPERTIES_FILE=./propsfile

# Obtain branch name
branch=$(git branch -a --points-at $(git log --oneline | head -1 | tail -1 | gawk '{ print $1 }') | grep -v detached | sed 's#[ \t]*remotes/origin/##g' | grep master)
if [ "x${branch}" == "x" ]
then
  branch=$(git branch -a --points-at $(git log --oneline | head -1 | tail -1 | gawk '{ print $1 }') | grep -v detached | sed 's#[ \t]*remotes/origin/##g' | head -1)
fi
if [ "x${branch}" == "x" ]
then
  branch=$(git branch -a --points-at $(git log --oneline | head -2 | tail -1 | gawk '{ print $1 }') | grep -v detached | sed 's#[ \t]*remotes/origin/##g' | grep master)
fi
if [ "x${branch}" == "x" ]
then
  branch=$(git branch -a --points-at $(git log --oneline | head -2 | tail -1 | gawk '{ print $1 }') | grep -v detached | sed 's#[ \t]*remotes/origin/##g' | head -1)
fi

rm -f ${PROPERTIES_FILE}
echo GIT_BRANCH_SHORT_NAME=$branch > ${PROPERTIES_FILE}
echo GIT_TAG_NAME=$(echo $GIT_BRANCH | sed 's/.*tags\///g') > ${PROPERTIES_FILE}
