#!/bin/bash

LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null)

if [ -z "$LATEST_TAG" ]; then
  LATEST_TAG=$(git rev-list --max-parents=0 HEAD)
fi

echo "## 🚀 New Features" > changelog.md
git log $LATEST_TAG..HEAD --grep "Feature:" --pretty=format:"- %s by @%an" >> changelog.md
echo "" >> changelog.md

echo "## 🐛 Bug Fixes" >> changelog.md
git log $LATEST_TAG..HEAD --grep "Fix:" --pretty=format:"- %s by @%an" >> changelog.md
echo "" >> changelog.md

echo "## 🛠️ Maintenance" >> changelog.md
git log $LATEST_TAG..HEAD --grep "Chore:" --pretty=format:"- %s by @%an" >> changelog.md
echo "" >> changelog.md

echo "## 🧩 Dependencies" >> changelog.md
git log $LATEST_TAG..HEAD --grep "Dep:" --pretty=format:"- %s by @%an" >> changelog.md
echo "" >> changelog.md
