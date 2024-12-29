#!/bin/bash

# Define the changelog file path
CHANGELOG_FILE="CHANGELOG.md"

# Retrieve the latest tag and the current tag from environment variables
LATEST_TAG=${previous_tag:-"N/A"}
NEW_TAG=${current_tag:-"N/A"}

if [ "$LATEST_TAG" == "N/A" ]; then
  echo "No previous tag found. Initial release."
  LATEST_TAG=""
fi

echo "# 🚀 Release $NEW_TAG" > $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE
echo "🎉 **What's New in this Release?**" >> $CHANGELOG_FILE
echo "🔍 Review the full list of changes below." >> $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE
echo "---" >> $CHANGELOG_FILE

# Generate sections for features, fixes, and other changes
echo "## 🚀 Features" >> $CHANGELOG_FILE
git log --pretty=format:"- 🚀 **Feature:** %s by @%an" $LATEST_TAG..HEAD --grep "Feature:" >> $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE

echo "## 🐛 Bug Fixes" >> $CHANGELOG_FILE
git log --pretty=format:"- 🐛 **Fix:** %s by @%an" $LATEST_TAG..HEAD --grep "Fix:" >> $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE

echo "## 🧩 Enhancements" >> $CHANGELOG_FILE
git log --pretty=format:"- 🧩 **Update:** %s by @%an" $LATEST_TAG..HEAD --grep "Update:" >> $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE

# Full commit history link
echo "## 📦 Full Commit History" >> $CHANGELOG_FILE
echo "**[🔗 Compare Changes](https://github.com/${GITHUB_REPOSITORY}/compare/${LATEST_TAG}...${NEW_TAG})**" >> $CHANGELOG_FILE
