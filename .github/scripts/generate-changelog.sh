#!/bin/bash

# Define the changelog file path
CHANGELOG_FILE="CHANGELOG.md"

# Retrieve the latest tag and the current tag from environment variables
LATEST_TAG=${previous_tag:-"N/A"}
NEW_TAG=${current_tag:-"N/A"}

# Initialize changelog
if [ "$LATEST_TAG" == "N/A" ]; then
  echo "No previous tag found. Initial release."
  LATEST_TAG=""
fi

# Create or update the changelog
echo "## 🚀 Release $NEW_TAG" > $CHANGELOG_FILE
echo "### What's Changed" >> $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE

# Categories initialization
FEATURES=""
FIXES=""
DOCS=""
MAINTENANCE=""

# Append commit history to the correct categories
while IFS= read -r line; do
  case "$line" in
    "Feature:"*) FEATURES+="- ${line}\n" ;;
    "Fix:"*) FIXES+="- ${line}\n" ;;
    "Docs:"*) DOCS+="- ${line}\n" ;;
    "Chore:"*) MAINTENANCE+="- ${line}\n" ;;
  esac
done < <(git log --pretty=format:"%s" $LATEST_TAG..HEAD)

# Add categories to changelog
echo "**🌟 Features**" >> $CHANGELOG_FILE
if [ -n "$FEATURES" ]; then
  echo -e "$FEATURES" >> $CHANGELOG_FILE
else
  echo "_- No new features_" >> $CHANGELOG_FILE
fi

echo "**🐛 Fixes**" >> $CHANGELOG_FILE
if [ -n "$FIXES" ]; then
  echo -e "$FIXES" >> $CHANGELOG_FILE
else
  echo "_- No bugs fixed_" >> $CHANGELOG_FILE
fi

echo "**📄 Documentation**" >> $CHANGELOG_FILE
if [ -n "$DOCS" ]; then
  echo -e "$DOCS" >> $CHANGELOG_FILE
else
  echo "_- No documentation updates_" >> $CHANGELOG_FILE
fi

echo "**🧰 Maintenance**" >> $CHANGELOG_FILE
if [ -n "$MAINTENANCE" ]; then
  echo -e "$MAINTENANCE" >> $CHANGELOG_FILE
else
  echo "_- No maintenance updates_" >> $CHANGELOG_FILE
fi

echo "" >> $CHANGELOG_FILE
REPO_URL="https://github.com/${GITHUB_REPOSITORY}/compare/"
echo "**Full commit history:** [Compare Changes](${REPO_URL}${LATEST_TAG}...${NEW_TAG})" >> $CHANGELOG_FILE
