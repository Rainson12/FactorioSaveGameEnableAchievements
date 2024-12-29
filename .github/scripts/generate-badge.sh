#!/bin/bash
REPO_OWNER=$(echo $GITHUB_REPOSITORY | cut -d'/' -f1)
REPO_NAME=$(echo $GITHUB_REPOSITORY | cut -d'/' -f2)

sed -i "s|OWNER/REPOSITORY|$REPO_OWNER/$REPO_NAME|g" README.md
