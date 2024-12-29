# 🚀 Factorio Save Game Achievement Enabler

This project is a console application that modifies Factorio save files to re-enable achievements that have been disabled due to the use of commands or the map editor.

[![.NET Windows Release 🚀](https://github.com/louanfontenele/FactorioSaveGameEnableAchievements/actions/workflows/release-windows-dotnet.yml/badge.svg)](https://github.com/louanfontenele/FactorioSaveGameEnableAchievements/actions/workflows/release-windows-dotnet.yml)

---

## ✨ Features

- 🧐 Automatically extracts save files.
- 🔍 Locates and modifies the necessary data to re-enable achievements.
- 🗂 Creates a backup of the original save file.
- 📦 Recompresses and restores the save file with a versioned zip name.

---

## 🗃️ Requirements

- .NET 8.0 SDK
- Visual Studio (or any compatible C# IDE)
- Factorio save files (.zip format)

---

## 🧑‍💻 How to Compile and Run

### 1. Clone the Repository

```bash
git clone https://github.com/louanfontenele/FactorioSaveGameEnableAchievements
cd FactorioSaveGameEnableAchievements
```

### 2. Build the Project

```bash
dotnet build
```

### 3. Run the Program

```bash
dotnet run
```

Alternatively, you can open the `.sln` file in Visual Studio and run the project using the built-in debugger.

---

## 🕹️ How to Use

1. Run the application.
2. When prompted, enter the path to the Factorio save file you wish to modify (e.g., `%appdata%\Factorio\saves\mysave.zip`).
3. The program will extract, modify, and repack the save file.
4. A backup of the original save will be created with the `.bak` extension.

---

## 📁 Project Structure

```
FactorioSaveGameEnableAchievements/
│
├── FactorioSaveGameEnableAchievements.sln   # Solution file
├── Program.cs                                # Main application logic
├── FileProcessor.cs                          # Handles ZLib compression and decompression
├── .github/                                  # GitHub Actions workflows
│   ├── release-windows-dotnet.yml            # Workflow for automated releases
│   └── release-drafter.yml                   # Configuration for changelog generation
└── README.md                                 # Project documentation
```

---

## 📊 Automated Release Process

### ✅ How Releases Work

- **Automatic Changelog Generation**:\
  Every time you push a commit to `master`, a GitHub Action workflow automatically generates a changelog based on the commit messages.
- **Versioning**:\
  The project uses semantic versioning based on the format:

  ```
  GameVersion-PatchVersion (e.g., 2.0.28-1.1)
  ```

- **New Tag and Release**:\
  A new GitHub release is created with the changelog and the compiled executable `.zip`.

  The generated zip will follow the format:

  ```
  FactorioSaveGameEnableAchievements-<version>.zip (e.g., FactorioSaveGameEnableAchievements-2.0.28-1.0.zip)
  ```

---

### 🔧 How to Format Commits (For Changelog)

To ensure the changelog is well-organized, follow this commit message format:

```bash
git commit -m "Feature: Add new gameplay mechanic"
git commit -m "Fix: Resolve crash on save file load"
git commit -m "Update: Modify save structure"
git commit -m "Remove: Deprecated feature"
```

- **Feature:** For new additions.
- **Fix:** For bug fixes.
- **Update:** For enhancements or improvements.
- **Remove:** For deletions or deprecated features.

---

## 📦 Full Changelog

The changelog is automatically generated with every release.

To view the latest changes, check the **[Releases Section](<https://github.com/${{> github.repository }}/releases)**.\
For a full list of changes:\
[Compare Changes](<https://github.com/${{> github.repository }}/compare)

---

## ⚠️ Error Handling

- ❌ If the program encounters an invalid save file path, it will notify the user and exit.
- 🛡️ Any errors during file extraction or modification will be logged to the console.

---

## 📝 Notes

- ⚙️ Ensure the save file is not in use by Factorio while running this tool.
- 🏅 This program only modifies saves that have achievements disabled by running commands or using the map editor.

---

## 📄 License

BSD 2-Clause License

```
Copyright (c) 2024, louanfontenele
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
...
```

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss the changes you would like to make.\
To contribute:

```bash
git checkout -b feature/your-feature
git commit -m "Feature: Add your feature"
git push origin feature/your-feature
```

---

## 📩 Contact

For questions or issues, open an [issue](<https://github.com/${{> github.repository }}/issues) or contact directly via GitHub.
