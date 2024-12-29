#!/bin/bash

LATEST_TAG=$(git describe --tags $(git rev-list --tags --max-count=1))
NEW_TAG=$(git describe --tags --abbrev=0 HEAD)

echo "## What's Changed" > changelog.md
echo "" >> changelog.md

git log --pretty=format:"- %s by @%an" $LATEST_TAG..HEAD >> changelog.md

echo "" >> changelog.md
echo "**Full commit history:** [Compare Changes](https://github.com/$GITHUB_REPOSITORY/compare/$LATEST_TAG...$NEW_TAG)" >> changelog.md
