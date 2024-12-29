#!/bin/bash

# Define the changelog file path
CHANGELOG_FILE="CHANGELOG.md"

# Retrieve the latest tag and the current tag from environment variables
LATEST_TAG=${previous_tag:-"N/A"}
NEW_TAG=${current_tag:-"N/A"}

# Fetch GitHub username using GitHub API
GITHUB_USERNAME=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/users/$(git config user.email | cut -d'@' -f1)" | jq -r .login)

# Initialize changelog
if [ "$LATEST_TAG" == "N/A" ]; then
  echo "No previous tag found. Initial release."
  LATEST_TAG=""
fi

# Create or update the changelog
echo "## Release $NEW_TAG" > $CHANGELOG_FILE
echo "What's Changed" >> $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE

# Append commit history
if [ -n "$LATEST_TAG" ]; then
  git log --pretty=format:"- %s by @$GITHUB_USERNAME" $LATEST_TAG..HEAD >> $CHANGELOG_FILE
else
  git log --pretty=format:"- %s by @$GITHUB_USERNAME" HEAD >> $CHANGELOG_FILE
fi

echo "" >> $CHANGELOG_FILE
REPO_URL="https://github.com/${GITHUB_REPOSITORY}/compare/"
echo "**\n\nFull commit history:** [Compare Changes](${REPO_URL}${LATEST_TAG}...${NEW_TAG})" >> $CHANGELOG_FILE
