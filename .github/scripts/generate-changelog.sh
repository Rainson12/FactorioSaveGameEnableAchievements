#!/bin/bash

# Define tags
LATEST_TAG=$(git describe --tags --abbrev=0)
NEW_TAG=$(git describe --tags --abbrev=0 HEAD)

# Gera changelog bonito
echo "## 🚀 New Features" > changelog.md
git log $LATEST_TAG..HEAD --grep "Feature:" --pretty=format:"- %s by @%an" >> changelog.md

echo "" >> changelog.md
echo "## 🐛 Bug Fixes" >> changelog.md
git log $LATEST_TAG..HEAD --grep "Fix:" --pretty=format:"- %s by @%an" >> changelog.md

echo "" >> changelog.md
echo "## 🛠️ Maintenance" >> changelog.md
git log $LATEST_TAG..HEAD --grep "Chore:" --pretty=format:"- %s by @%an" >> changelog.md

echo "" >> changelog.md
echo "**Full commit history:** [Compare Changes](https://github.com/${{ github.repository }}/compare/$LATEST_TAG...$NEW_TAG)"
