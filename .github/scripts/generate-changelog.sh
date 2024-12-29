#!/bin/bash

# Define the changelog file path
CHANGELOG_FILE="CHANGELOG.md"

# Retrieve the latest tag and the current tag from environment variables
LATEST_TAG=${previous_tag:-"N/A"}
NEW_TAG=${current_tag:-"N/A"}

# Initialize changelog sections
FEATURES=""
FIXES=""
UPDATES=""
REMOVES=""

# Initialize changelog
if [ "$LATEST_TAG" == "N/A" ]; then
  echo "No previous tag found. Initial release."
  LATEST_TAG=""
fi

# Create or update the changelog
echo "## 🚀 Release $NEW_TAG 🎉" > $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE
echo "### What's Changed" >> $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE

# Log commits and classify by prefix
git log --pretty=format:"%s" $LATEST_TAG..HEAD | while read -r line; do
  if [[ $line == Feature:* ]]; then
    FEATURES+="- ${line#Feature: }\n"
  elif [[ $line == Fix:* ]]; then
    FIXES+="- ${line#Fix: }\n"
  elif [[ $line == Update:* ]]; then
    UPDATES+="- ${line#Update: }\n"
  elif [[ $line == Remove:* ]]; then
    REMOVES+="- ${line#Remove: }\n"
  fi
done

# Populate changelog with fallback if sections are empty
echo "### 🌟 Features" >> $CHANGELOG_FILE
if [ -n "$FEATURES" ]; then
  echo -e "$FEATURES" >> $CHANGELOG_FILE
else
  echo "- _*No new features*_ " >> $CHANGELOG_FILE
fi

echo "" >> $CHANGELOG_FILE

echo "### 🐛 Fixes" >> $CHANGELOG_FILE
if [ -n "$FIXES" ]; then
  echo -e "$FIXES" >> $CHANGELOG_FILE
else
  echo "- _*No bug fixes*_ " >> $CHANGELOG_FILE
fi

echo "" >> $CHANGELOG_FILE

echo "### 🔄 Updates" >> $CHANGELOG_FILE
if [ -n "$UPDATES" ]; then
  echo -e "$UPDATES" >> $CHANGELOG_FILE
else
  echo "- _*No updates*_ " >> $CHANGELOG_FILE
fi

echo "" >> $CHANGELOG_FILE

echo "### 🗑️ Removes" >> $CHANGELOG_FILE
if [ -n "$REMOVES" ]; then
  echo -e "$REMOVES" >> $CHANGELOG_FILE
else
  echo "- _*Nothing removed*_ " >> $CHANGELOG_FILE
fi

# Add full commit history link
REPO_URL="https://github.com/${GITHUB_REPOSITORY}/compare/"
echo "" >> $CHANGELOG_FILE
echo "**Full commit history:** [Compare Changes](${REPO_URL}${LATEST_TAG}...${NEW_TAG})" >> $CHANGELOG_FILE
