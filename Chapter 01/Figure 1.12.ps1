# Figure 1.12 - Working with the FileSystem Provider
# Chapter 1: Introduction to Advanced PowerShell Concepts
# PowerShell Advanced Cookbook - BPB Publications

# The FileSystem provider is the most commonly used provider in PowerShell.
# You use it every time you work with files and directories, often without
# realizing you're using a provider at all.

# Navigate to a directory using Set-Location (alias: cd)
# This changes your current working directory
Set-Location C:\Temp

# Navigate back to the root of the C: drive
Set-Location C:\

# List contents of a directory using Get-ChildItem (alias: dir, ls)
# This returns FileInfo and DirectoryInfo objects
Get-ChildItem C:\Temp

# Expected Output:
#     Directory: C:\Temp
#
# Mode                 LastWriteTime         Length Name
# ----                 -------------         ------ ----
# d-----        12/15/2024   2:30 PM                Subfolder
# -a----        12/15/2024   2:25 PM           1024 example.txt
# -a----        12/15/2024   2:26 PM           2048 data.csv

# Using the pipeline with ForEach-Object to process each item
# This demonstrates how provider output integrates with the pipeline
Get-ChildItem C:\Temp | ForEach-Object {
    Write-Output "Item: $($_.Name) - Type: $($_.GetType().Name)"
}

# Expected Output:
# Item: Subfolder - Type: DirectoryInfo
# Item: example.txt - Type: FileInfo
# Item: data.csv - Type: FileInfo

# Common Get-ChildItem parameters for the FileSystem provider:

# List only files (exclude directories)
Get-ChildItem C:\Temp -File

# List only directories (exclude files)
Get-ChildItem C:\Temp -Directory

# Recursive listing - include all subdirectories
Get-ChildItem C:\Temp -Recurse

# Filter by extension using -Filter (efficient, processed by provider)
Get-ChildItem C:\Temp -Filter "*.txt"

# Filter using wildcards in the path
Get-ChildItem C:\Temp\*.log

# Include hidden and system files
Get-ChildItem C:\Temp -Force

# Combine parameters: Find all .ps1 files recursively
Get-ChildItem C:\Temp -Filter "*.ps1" -Recurse -File

# Working with paths - absolute vs relative
# Absolute path (starts from drive root)
Get-ChildItem -Path C:\Windows\System32

# Relative path (relative to current location)
Set-Location C:\Windows
Get-ChildItem -Path .\System32

# Using the -LiteralPath parameter for paths with special characters
# Use this when your path contains wildcards that should be treated literally
Get-ChildItem -LiteralPath "C:\Temp\File[1].txt"

# Tip: The FileSystem provider supports the -Credential parameter,
# allowing you to access network shares with alternate credentials:
# Get-ChildItem \\server\share -Credential (Get-Credential)
