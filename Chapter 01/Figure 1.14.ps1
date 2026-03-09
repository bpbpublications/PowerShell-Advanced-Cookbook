# Figure 1.14 - Output from a Specific Software Registry Key
# Chapter 1: Introduction to Advanced PowerShell Concepts
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows only

# This example shows how to drill down into a specific software's registry key
# to view its configuration and settings.

# First, let's find what software keys are available on your system
# This helps identify valid paths to explore
Get-ChildItem HKCU:\SOFTWARE\ | Select-Object -First 10 Name

# The book example uses 7-Zip, but this may not be installed on your system.
# Let's demonstrate with a key that exists on most Windows systems: Microsoft

# View subkeys under a specific software vendor
Get-ChildItem HKCU:\SOFTWARE\Microsoft\ | Select-Object -First 10 Name

# Expected Output (varies by system):
# Name
# ----
# Active Setup
# Command Processor
# Console
# IdentityCRL
# Internet Explorer
# Office
# Windows
# ...

# If you have 7-Zip installed, you can view its settings:
# Get-ChildItem HKCU:\SOFTWARE\7-Zip\
#
# Expected Output:
#     Hive: HKEY_CURRENT_USER\SOFTWARE\7-Zip
#
# Name                           Property
# ----                           --------
# Compression
# Extraction
# FM                             ShowDots : 0
#                                ShowRealFileIcons : 0
#                                FullRow : 0
# Options

# Safely check if a registry key exists before accessing it
$keyPath = "HKCU:\SOFTWARE\7-Zip"
if (Test-Path $keyPath) {
    Write-Output "7-Zip registry key found. Contents:"
    Get-ChildItem $keyPath
} else {
    Write-Output "7-Zip is not installed or has no user settings."
    Write-Output "Try exploring: Get-ChildItem HKCU:\SOFTWARE\Microsoft\"
}

# View all properties of a specific key (not subkeys)
# Get-Item returns the key itself with its properties
Get-Item HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ |
    Select-Object -ExpandProperty Property

# Expected Output (varies):
# ShellState
# Link
# BrowseNewProcess
# ...

# Get property values from a registry key
Get-ItemProperty HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\

# Tip: The difference between Get-Item and Get-ChildItem in the registry:
# - Get-Item: Returns the key itself (with its properties/values)
# - Get-ChildItem: Returns the subkeys (child keys) under the specified key
