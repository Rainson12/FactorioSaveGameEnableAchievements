# .github/scripts/generate-changelog.sh
# Generate changelog sections by commit type
echo "## 🚀 New Features" > changelog.md
git log $(git describe --tags --abbrev=0 @^)..@ --grep "Feature:" --pretty=format:"- %s by @%an" >> changelog.md
echo "" >> changelog.md

echo "## 🐛 Bug Fixes" >> changelog.md
git log $(git describe --tags --abbrev=0 @^)..@ --grep "Fix:" --pretty=format:"- %s by @%an" >> changelog.md
echo "" >> changelog.md

echo "## 🛠️ Maintenance" >> changelog.md
git log $(git describe --tags --abbrev=0 @^)..@ --grep "chore:" --pretty=format:"- %s by @%an" >> changelog.md
echo "" >> changelog.md
