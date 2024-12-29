#!/bin/bash

LATEST_TAG=$(git describe --tags --abbrev=0)
echo "Generating changelog since $LATEST_TAG..."

echo "## 🚀 New Features" > changelog.md
git log $LATEST_TAG..HEAD --grep "Feature:" --pretty=format:"- %s by @%an" >> changelog.md

echo -e "\n## 🐛 Bug Fixes" >> changelog.md
git log $LATEST_TAG..HEAD --grep "Fix:" --pretty=format:"- %s by @%an" >> changelog.md

echo -e "\n## 🛠️ Chores" >> changelog.md
git log $LATEST_TAG..HEAD --grep "Chore:" --pretty=format:"- %s by @%an" >> changelog.md

echo -e "\nChangelog generated successfully! 🎉"
