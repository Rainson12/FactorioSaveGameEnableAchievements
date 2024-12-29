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
echo "" >> $CHANGELOG_FILE
echo "### What's Changed" >> $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE

# Initialize categories
FEATURES=""
FIXES=""
DOCS=""
MAINTENANCE=""

# Loop through the commits and categorize them
while IFS= read -r line; do
  COMMIT_MESSAGE=$(echo "$line" | awk '{for(i=2;i<=NF;++i)printf $i" "; print""}')
  AUTHOR=$(echo "$line" | awk '{print $NF}')
  
  if [[ "$line" == *"Feature:"* ]]; then
    FEATURES+="🌟 $COMMIT_MESSAGE by @$AUTHOR\n"
  elif [[ "$line" == *"Fix:"* ]]; then
    FIXES+="🐛 $COMMIT_MESSAGE by @$AUTHOR\n"
  elif [[ "$line" == *"Docs:"* ]]; then
    DOCS+="📄 $COMMIT_MESSAGE by @$AUTHOR\n"
  elif [[ "$line" == *"Chore:"* ]]; then
    MAINTENANCE+="🧰 $COMMIT_MESSAGE by @$AUTHOR\n"
  fi
done < <(git log --pretty=format:"%s by %an" $LATEST_TAG..HEAD)

# Append sections to changelog
echo "**🌟 Features**" >> $CHANGELOG_FILE
if [ -z "$FEATURES" ]; then
  echo "_No new features_" >> $CHANGELOG_FILE
else
  echo -e "$FEATURES" >> $CHANGELOG_FILE
fi
echo "" >> $CHANGELOG_FILE

echo "**🐛 Fixes**" >> $CHANGELOG_FILE
if [ -z "$FIXES" ]; then
  echo "_No bug fixes_" >> $CHANGELOG_FILE
else
  echo -e "$FIXES" >> $CHANGELOG_FILE
fi
echo "" >> $CHANGELOG_FILE

echo "**📄 Documentation**" >> $CHANGELOG_FILE
if [ -z "$DOCS" ]; then
  echo "_No documentation updates_" >> $CHANGELOG_FILE
else
  echo -e "$DOCS" >> $CHANGELOG_FILE
fi
echo "" >> $CHANGELOG_FILE

echo "**🧰 Maintenance**" >> $CHANGELOG_FILE
if [ -z "$MAINTENANCE" ]; then
  echo "_No maintenance updates_" >> $CHANGELOG_FILE
else
  echo -e "$MAINTENANCE" >> $CHANGELOG_FILE
fi
echo "" >> $CHANGELOG_FILE

# Add full commit history link
REPO_URL="https://github.com/${GITHUB_REPOSITORY}/compare/"
echo "**Full commit history:** [Compare Changes](${REPO_URL}${LATEST_TAG}...${NEW_TAG})" >> $CHANGELOG_FILE
