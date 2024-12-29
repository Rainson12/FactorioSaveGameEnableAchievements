#!/bin/bash

# Get previous and current tags
LATEST_TAG=$(git tag --sort=-v:refname | grep "^2.0.28-" | head -n 1)
NEW_TAG=$(echo "$LATEST_TAG" | awk -F '-' '{printf "%s-%0.1f", $1, $2 + 0.1}')

# Generate the changelog content
echo "## What's Changed" > changelog.md
echo "" >> changelog.md
git log --pretty=format:"- %s by @%an" $LATEST_TAG..HEAD >> changelog.md
echo "" >> changelog.md

# Append Full commit history section
echo "**Full commit history:** [Compare Changes](https://github.com/${GITHUB_REPOSITORY}/compare/$LATEST_TAG...$NEW_TAG)" >> changelog.md
