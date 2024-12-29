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
echo "🚀 **Release $NEW_TAG**" > $CHANGELOG_FILE
echo "### What's Changed" >> $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE

# Initialize sections for each type of change
FEATURES=""
FIXES=""
UPDATES=""
REMOVES=""

# Fetch commit history and categorize
if [ -n "$LATEST_TAG" ]; then
  COMMITS=$(git log --pretty=format:"%s" $LATEST_TAG..HEAD)
else
  COMMITS=$(git log --pretty=format:"%s" HEAD)
fi

# Loop through each commit and categorize
while IFS= read -r line; do
  case "$line" in
    *"Feature:"* | *"feat:"* | *"Add:"*)
      FEATURES+="- ${line#*: }\n"
      ;;
    *"Fix:"* | *"fix:"* | *"Bug:"* | *"Patch:"*)
      FIXES+="- ${line#*: }\n"
      ;;
    *"Update:"* | *"update:"* | *"Improvement:"*)
      UPDATES+="- ${line#*: }\n"
      ;;
    *"Remove:"* | *"remove:"* | *"Delete:"*)
      REMOVES+="- ${line#*: }\n"
      ;;
  esac
done <<< "$COMMITS"

# Append categorized sections
if [ -n "$FEATURES" ]; then
  echo "🌟 **Features**" >> $CHANGELOG_FILE
  echo -e "$FEATURES" >> $CHANGELOG_FILE
else
  echo "🌟 **Features**" >> $CHANGELOG_FILE
  echo "- _*No new features*_ " >> $CHANGELOG_FILE
fi

if [ -n "$FIXES" ]; then
  echo "🐛 **Fixes**" >> $CHANGELOG_FILE
  echo -e "$FIXES" >> $CHANGELOG_FILE
else
  echo "🐛 **Fixes**" >> $CHANGELOG_FILE
  echo "- _*No bug fixes*_ " >> $CHANGELOG_FILE
fi

if [ -n "$UPDATES" ]; then
  echo "🔄 **Updates**" >> $CHANGELOG_FILE
  echo -e "$UPDATES" >> $CHANGELOG_FILE
else
  echo "🔄 **Updates**" >> $CHANGELOG_FILE
  echo "- _*No updates*_ " >> $CHANGELOG_FILE
fi

if [ -n "$REMOVES" ]; then
  echo "🗑️ **Removes**" >> $CHANGELOG_FILE
  echo -e "$REMOVES" >> $CHANGELOG_FILE
else
  echo "🗑️ **Removes**" >> $CHANGELOG_FILE
  echo "- _*Nothing removed*_ " >> $CHANGELOG_FILE
fi

echo "" >> $CHANGELOG_FILE
echo "**Full commit history:** [Compare Changes](https://github.com/${GITHUB_REPOSITORY}/compare/${LATEST_TAG}...${NEW_TAG})" >> $CHANGELOG_FILE
