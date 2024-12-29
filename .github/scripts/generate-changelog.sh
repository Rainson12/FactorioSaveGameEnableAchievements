#!/bin/bash
LATEST_TAG=$(git describe --tags --abbrev=0)
echo "## 🚀 New Features" > changelog.md
git log $LATEST_TAG..HEAD --grep "Feature:" --pretty=format:"- %s by @%an" >> changelog.md
echo "" >> changelog.md

echo "## 🐛 Bug Fixes" >> changelog.md
git log $LATEST_TAG..HEAD --grep "Fix:" --pretty=format:"- %s by @%an" >> changelog.md
echo "" >> changelog.md

echo "## 🛠️ Maintenance" >> changelog.md
git log $LATEST_TAG..HEAD --grep "chore:" --pretty=format:"- %s by @%an" >> changelog.md
echo "" >> changelog.md
