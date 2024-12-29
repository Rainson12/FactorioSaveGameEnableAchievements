#!/bin/bash

# Define the changelog file path
CHANGELOG_FILE="CHANGELOG.md"

# Retrieve the latest tag and the current tag from environment variables
LATEST_TAG=${previous_tag:-"N/A"}
NEW_TAG=${current_tag:-"N/A"}

# Create or update the changelog
echo "## Release $NEW_TAG" > $CHANGELOG_FILE
echo "What's Changed" >> $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE

# Format the commit history nicely
git log --pretty=format:"- %s by @%an" $LATEST_TAG..HEAD >> $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE

echo "**Full commit history:** [Compare Changes](https://github.com/${{ github.repository }}/compare/$LATEST_TAG...$NEW_TAG)" >> $CHANGELOG_FILE
