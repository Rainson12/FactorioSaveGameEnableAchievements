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

# Create or update the changelog with a professional structure
{
  echo "## 🚀 Release $NEW_TAG"
  echo "### What's Changed"
  echo ""

  # Append categorized commit history using prefixes (Feature:, Fix:, etc.)
  echo "#### 🌟 Features"
  git log --pretty=format:"- ✨ %s by @$GITHUB_USERNAME" $LATEST_TAG..HEAD | grep -i '^Feature:' | sed 's/Feature: //g' || echo "- _No new features_"
  echo ""
  
  echo "#### 🐛 Fixes"
  git log --pretty=format:"- 🛠️ %s by @$GITHUB_USERNAME" $LATEST_TAG..HEAD | grep -i '^Fix:' | sed 's/Fix: //g' || echo "- _No bug fixes_"
  echo ""
  
  echo "#### 📄 Documentation"
  git log --pretty=format:"- 📝 %s by @$GITHUB_USERNAME" $LATEST_TAG..HEAD | grep -i '^Docs:' | sed 's/Docs: //g' || echo "- _No documentation updates_"
  echo ""
  
  echo "#### 🧰 Maintenance"
  git log --pretty=format:"- 🔧 %s by @$GITHUB_USERNAME" $LATEST_TAG..HEAD | grep -i '^Chore:\|^Refactor:' | sed 's/Chore: //g; s/Refactor: //g' || echo "- _No maintenance updates_"
  echo ""
  
  echo "---"
  
  # Full commit history with a compare link
  REPO_URL="https://github.com/${GITHUB_REPOSITORY}/compare/"
  echo "**Full commit history:** [Compare Changes](${REPO_URL}${LATEST_TAG}...${NEW_TAG})"
} > $CHANGELOG_FILE
