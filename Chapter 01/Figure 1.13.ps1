# Figure 1.13 - Output from HKCU:\SOFTWARE Registry Key
# Chapter 1: Introduction to Advanced PowerShell Concepts
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows only

# The Windows Registry is a hierarchical database storing system and application
# configuration. PowerShell's Registry provider lets you navigate it like a filesystem.

# Registry Root Keys (Hives):
# - HKEY_CURRENT_USER (HKCU:) - Settings for the currently logged-in user
# - HKEY_LOCAL_MACHINE (HKLM:) - System-wide settings (requires elevation to modify)

# WARNING: Be careful when modifying the registry. Incorrect changes can cause
# system instability. Always back up before making changes.

# List all software-related registry keys for the current user
# The SOFTWARE key contains application settings and configurations
Get-ChildItem HKCU:\SOFTWARE\

# Expected Output (abbreviated - your output will vary based on installed software):
#     Hive: HKEY_CURRENT_USER\SOFTWARE
#
# Name                           Property
# ----                           --------
# 7-Zip                          Path : C:\Program Files\7-Zip\
# Adobe
# Classes
# Google
# Microsoft
# Mozilla
# ...

# Understanding the output:
# - Name: The registry key name (often matches the software/company name)
# - Property: Shows property names if the key has direct properties

# Filter to find specific software keys using wildcards
Get-ChildItem HKCU:\SOFTWARE\ -Name | Where-Object { $_ -like "*Microsoft*" }

# Expected Output:
# Microsoft

# Count how many software keys exist for the current user
$softwareKeys = Get-ChildItem HKCU:\SOFTWARE\
Write-Output "Total software keys in HKCU:\SOFTWARE: $($softwareKeys.Count)"

# View registry keys with their full paths
Get-ChildItem HKCU:\SOFTWARE\ | Select-Object Name, PSPath

# Expected Output:
# Name                                    PSPath
# ----                                    ------
# HKEY_CURRENT_USER\SOFTWARE\7-Zip        Microsoft.PowerShell.Core\Registry::...
# HKEY_CURRENT_USER\SOFTWARE\Adobe        Microsoft.PowerShell.Core\Registry::...
# ...

# Navigate into the registry like a filesystem
Set-Location HKCU:\SOFTWARE\
Get-ChildItem

# Return to the filesystem when done
Set-Location C:\

# Tip: Use Get-Item to get a specific key, Get-ChildItem to list subkeys
# Get-Item HKCU:\SOFTWARE\Microsoft    # Returns the Microsoft key itself
# Get-ChildItem HKCU:\SOFTWARE\Microsoft  # Returns subkeys under Microsoft
