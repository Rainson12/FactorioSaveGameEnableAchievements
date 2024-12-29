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

# Start changelog structure
{
  echo "## 🚀 Release $NEW_TAG"
  echo "### What's Changed"
  echo ""
  
  # Features Section
  echo "#### 🌟 Features"
  FEATURE_COMMITS=$(git log --pretty=format:"- %s by @$GITHUB_USERNAME" $LATEST_TAG..HEAD | grep -Ei '^(Feature:|feat:)' || echo "- *No new features*")
  echo "$FEATURE_COMMITS"
  echo ""
  
  # Fixes Section
  echo "#### 🐛 Fixes"
  FIX_COMMITS=$(git log --pretty=format:"- %s by @$GITHUB_USERNAME" $LATEST_TAG..HEAD | grep -Ei '^(Fix:|bug:)' || echo "- *No bug fixes*")
  echo "$FIX_COMMITS"
  echo ""
  
  # Documentation Section
  echo "#### 📄 Documentation"
  DOC_COMMITS=$(git log --pretty=format:"- %s by @$GITHUB_USERNAME" $LATEST_TAG..HEAD | grep -Ei '^(Docs:|doc:)' || echo "- *No documentation updates*")
  echo "$DOC_COMMITS"
  echo ""
  
  # Maintenance Section
  echo "#### 🧰 Maintenance"
  MAINTENANCE_COMMITS=$(git log --pretty=format:"- %s by @$GITHUB_USERNAME" $LATEST_TAG..HEAD | grep -Ei '^(Chore:|Refactor:|maint:)' || echo "- *No maintenance updates*")
  echo "$MAINTENANCE_COMMITS"
  echo ""

  echo "---"
  
  # Full commit history link
  REPO_URL="https://github.com/${GITHUB_REPOSITORY}/compare/"
  echo "**Full commit history:** [Compare Changes](${REPO_URL}${LATEST_TAG}...${NEW_TAG})"
} > $CHANGELOG_FILE
