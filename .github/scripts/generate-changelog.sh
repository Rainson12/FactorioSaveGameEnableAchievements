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
DOCS=""
MAINTENANCE=""

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
      FEATURES+="🌟 $line\n"
      ;;
    *"Fix:"* | *"fix:"* | *"Bug:"* | *"Patch:"*)
      FIXES+="🐛 $line\n"
      ;;
    *"Doc:"* | *"docs:"* | *"Documentation:"*)
      DOCS+="📄 $line\n"
      ;;
    *"Chore:"* | *"Refactor:"* | *"Maint:"* | *"Build:"*)
      MAINTENANCE+="🧰 $line\n"
      ;;
    *)
      # Catch-all if no category matches
      MAINTENANCE+="🧰 $line\n"
      ;;
  esac
done <<< "$COMMITS"

# Append categorized sections
if [ -n "$FEATURES" ]; then
  echo "🌟 **Features**" >> $CHANGELOG_FILE
  echo -e "$FEATURES" >> $CHANGELOG_FILE
else
  echo "🌟 **Features**" >> $CHANGELOG_FILE
  echo "_No new features_" >> $CHANGELOG_FILE
fi

if [ -n "$FIXES" ]; then
  echo "🐛 **Fixes**" >> $CHANGELOG_FILE
  echo -e "$FIXES" >> $CHANGELOG_FILE
else
  echo "🐛 **Fixes**" >> $CHANGELOG_FILE
  echo "_No bug fixes_" >> $CHANGELOG_FILE
fi

if [ -n "$DOCS" ]; then
  echo "📄 **Documentation**" >> $CHANGELOG_FILE
  echo -e "$DOCS" >> $CHANGELOG_FILE
else
  echo "📄 **Documentation**" >> $CHANGELOG_FILE
  echo "_No documentation updates_" >> $CHANGELOG_FILE
fi

if [ -n "$MAINTENANCE" ]; then
  echo "🧰 **Maintenance**" >> $CHANGELOG_FILE
  echo -e "$MAINTENANCE" >> $CHANGELOG_FILE
else
  echo "🧰 **Maintenance**" >> $CHANGELOG_FILE
  echo "_No maintenance updates_" >> $CHANGELOG_FILE
fi

echo "" >> $CHANGELOG_FILE
echo "**Full commit history:** [Compare Changes](https://github.com/${GITHUB_REPOSITORY}/compare/${LATEST_TAG}...${NEW_TAG})" >> $CHANGELOG_FILE
