#!/bin/bash
REPO_OWNER=$(echo $GITHUB_REPOSITORY | cut -d'/' -f1)
REPO_NAME=$(echo $GITHUB_REPOSITORY | cut -d'/' -f2)

# Atualiza o badge e links
sed -i "s|OWNER/REPOSITORY|$REPO_OWNER/$REPO_NAME|g" README.md
sed -i "s|\${{ github.repository }}|$GITHUB_REPOSITORY|g" README.md
sed -i "s|\${{ github.repository_owner }}|$REPO_OWNER|g" README.md
