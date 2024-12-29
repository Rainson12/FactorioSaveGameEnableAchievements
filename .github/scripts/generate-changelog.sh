#!/bin/bash

# Define the changelog file path
CHANGELOG_FILE="CHANGELOG.md"

# Retrieve the latest tag and the current tag from environment variables
LATEST_TAG=${LATEST_TAG:-"N/A"}
NEW_TAG=${NEW_TAG:-"N/A"}

# Check if the latest tag exists, otherwise initialize
if [ "$LATEST_TAG" == "N/A" ]; then
  echo "No previous tag found. Initial release."
  LATEST_TAG=""
fi

# Create or update the changelog
echo "## Release $NEW_TAG" > $CHANGELOG_FILE
echo "What's Changed" >> $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE

# Append commit history if LATEST_TAG exists
if [ -n "$LATEST_TAG" ]; then
  git log --pretty=format:"- %s by @%ae" $LATEST_TAG..HEAD >> $CHANGELOG_FILE
else
  git log --pretty=format:"- %s by @%ae" HEAD >> $CHANGELOG_FILE
fi
echo "" >> $CHANGELOG_FILE

# Fix GitHub variable substitution
REPO_URL="https://github.com/${GITHUB_REPOSITORY}/compare/"
echo "**Full commit history:** [Compare Changes](${REPO_URL}${LATEST_TAG}...${NEW_TAG})" >> $CHANGELOG_FILE
