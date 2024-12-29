# 🚀 Factorio Save Game Achievement Enabler

This project is a console application that modifies Factorio save files to re-enable achievements that have been disabled due to the use of commands or the map editor.

## ✨ Features

- 🛠️ Automatically extracts save files.
- 🔍 Locates and modifies the necessary data to re-enable achievements.
- 🗂️ Creates a backup of the original save file.
- 📦 Recompresses and restores the save file.
- 🔄 Automated GitHub Releases with changelogs generated from commits and PRs.

## 📋 Requirements

- .NET 8.0 SDK
- Visual Studio (or any compatible C# IDE)
- Factorio save files (.zip format)

## 🛠️ How to Compile and Run

### 1. Clone the Repository

```bash
git clone https://github.com/Rainson12/FactorioSaveGameEnableAchievements
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

## 🚀 Automated Release Workflow

This project uses **GitHub Actions** to automate the release process.

### How it Works
- **Triggers**: A new release is automatically created when a tag is pushed (e.g., `v1.0.0`).
- **Draft Releases**: The changelog is generated dynamically from PRs and commits.
- **Manual Trigger**: Releases can also be triggered manually from the Actions tab.

### Key Files:
- `.github/workflows/release-windows-dotnet.yml` – Workflow to build and release .NET projects.
- `.github/release-drafter.yml` – Template for changelog generation.

### Create a Tag to Trigger a Release:
```bash
git tag v1.0.0
git push origin v1.0.0
```

### Manual Release:
Go to **Actions** → Select the workflow → **Run Workflow**.

## 🕹️ How to Use

1. Run the application.
2. When prompted, enter the path to the Factorio save file you wish to modify (e.g., `C:\Users\Username\AppData\Roaming\Factorio\saves\mysave.zip`).
3. The program will extract, modify, and repack the save file.
4. A backup of the original save will be created with the `.bak` extension.

## 📁 Project Structure

```
FactorioSaveGameEnableAchievements/
│
├── FactorioSaveGameEnableAchievements.sln   # Solution file
├── Program.cs                                # Main application logic
├── FileProcessor.cs                          # Handles ZLib compression and decompression
├── .github/workflows/release-windows-dotnet.yml # GitHub Actions workflow for releases
├── .github/release-drafter.yml               # Release drafter configuration
└── README.md                                 # Project documentation
```

## ⚠️ Error Handling

- ❌ If the program encounters an invalid save file path, it will notify the user and exit.
- 🛡️ Any errors during file extraction or modification will be logged to the console.

## 📝 Notes

- ⚙️ Ensure the save file is not in use by Factorio while running this tool.
- 🏅 This program only modifies saves that have achievements disabled by running commands or using the map editor.

## 📄 License

BSD 2-Clause License

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss the changes you would like to make.

