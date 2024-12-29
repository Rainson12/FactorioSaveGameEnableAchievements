#!/bin/bash
set -e

LATEST_TAG=${previous_tag}
NEW_TAG=${current_tag}

echo "Generating changelog from $LATEST_TAG to $NEW_TAG"

echo "## What's Changed" > changelog.md
echo "" >> changelog.md

# Coletar todos os commits entre as tags
git log $LATEST_TAG..HEAD --pretty=format:"- %s by @%an" >> changelog.md

echo "" >> changelog.md
echo "## 📦 Full Changelog" >> changelog.md

# Corrigido para usar a variável do GitHub corretamente
REPO_URL="https://github.com/${GITHUB_REPOSITORY}"
echo "**Full commit history:** [Compare Changes](${REPO_URL}/compare/$LATEST_TAG...$NEW_TAG)" >> changelog.md
