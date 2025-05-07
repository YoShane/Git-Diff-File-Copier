# Git Diff File Copier

A batch script that copies files that differ between two Git branches to a specified destination folder while preserving the directory structure.

## Description

This script identifies files that differ between two Git branches using `git diff` and copies them to a destination folder, maintaining the original folder structure. This is particularly useful for:

- Creating deployment packages with only changed files
- Preparing code reviews by isolating modified files
- Creating backups of modified files before making significant changes

## Features

- Compares any two Git branches to identify changed files
- Preserves directory structure when copying files
- Creates necessary directories automatically
- Provides detailed progress information
- Handles errors gracefully with appropriate messages

## Prerequisites

- Windows operating system
- Git installed and accessible from command line
- Write permissions to the destination folder

## Usage

1. Download `copy_git_diff_files.bat`
2. Run the script by double-clicking or from command prompt
3. When prompted, enter:
   - The branch name you want to compare (your current working branch)
   - The main branch name to compare against (defaults to "master" if left blank)
   - The destination folder where files should be copied

## Example

```
Please input your branch name: feature/new-login
Please input your main branch name (default: master): develop
Please input your destination folder (default: current path): C:\Deployments\LoginFeature
```

## Configuration

The script contains some default values that can be modified directly in the script file if needed:

- `SET "FileListTxt=diffFileTemp.txt"` - Temporary file to store the diff results (Do not delete this file)
- `SET "SourceFolder=D:\project\git_source_folder"` - Default source folder (your Git repository)

## How It Works

1. Uses Git to generate a list of changed files between two branches
2. Processes each file in the list
3. Creates the necessary directory structure in the destination folder
4. Copies each file, preserving the relative path
5. Reports success or errors for each operation

## Error Handling

The script includes error checking for:
- Invalid file list
- Non-existent source folder
- Permission issues when creating directories
- File copy failures

## License

This project is open source and available under the [MIT License](LICENSE).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Acknowledgments

- Thanks to the Git community for providing powerful diff tools
- Inspired by deployment workflows that require selective file copying
