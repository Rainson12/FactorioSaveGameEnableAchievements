#!/bin/bash

REPO_URL="https://github.com/${GITHUB_REPOSITORY}"
REPO_NAME=$(echo $GITHUB_REPOSITORY | cut -d'/' -f2)
OWNER=$(echo $GITHUB_REPOSITORY | cut -d'/' -f1)
BADGE_URL="$REPO_URL/actions/workflows/release-windows-dotnet.yml/badge.svg"

cat <<EOF > README.md
# 🚀 $REPO_NAME

This project is a console application that modifies Factorio save files to re-enable achievements disabled by commands or map editor.

---

## ✨ Features
- 🧐 Automatically extracts save files.
- 🔍 Modifies data to re-enable achievements.
- 🗂 Backs up the original save file.
- 📦 Recompresses the save file with a versioned zip.

---

## 🗃️ Requirements
- .NET 8.0 SDK
- Visual Studio or compatible C# IDE
- Factorio save files (.zip format)

---

## 🧑‍💻 How to Compile and Run
### 1. Clone the Repository
\`\`\`bash
git clone $REPO_URL
cd $REPO_NAME
\`\`\`

### 2. Build the Project
\`\`\`bash
dotnet build
\`\`\`

### 3. Run the Program
\`\`\`bash
dotnet run
\`\`\`

Alternatively, open the solution file in Visual Studio.

---

## 🕹️ How to Use
1. Run the application.
2. Enter the path to the save file (e.g., \`%appdata%\\Factorio\\saves\\mysave.zip\`).
3. The program modifies the save and creates a backup with \`.bak\`.

---

## 📊 Automated Release Process
- **Changelog Generation**: A changelog is automatically created with each release.
- **Versioning**: Semantic versioning is used (`GameVersion-PatchVersion`).
- **Release Output**: The zip follows the format:
\`\`\`
FactorioSaveGameEnableAchievements-<version>.zip
\`\`\`

---

### 🔧 Commit Format (For Changelog)
Use the following format to categorize commits:

\`\`\`bash
git commit -m "Feature: Add new mechanic"
git commit -m "Fix: Resolve save crash"
git commit -m "Update: Improve save structure"
git commit -m "Remove: Remove deprecated feature"
\`\`\`

---

## 📦 Full Changelog
Check the **[Releases Section]($REPO_URL/releases)**.  
Compare full changes **[here]($REPO_URL/compare)**.

---

## 📊 Status
[![Release Status]($BADGE_URL)]($REPO_URL/actions/workflows/release-windows-dotnet.yml)

---

## 📝 Notes
- Ensure the save file is not in use by Factorio.
- This tool modifies saves that disable achievements.

---

## 📩 Contact
For questions, open an **[issue]($REPO_URL/issues)** or contact directly via GitHub.

EOF
