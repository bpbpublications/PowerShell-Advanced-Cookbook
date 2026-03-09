# Figure 1.11 - Get-PSProvider cmdlet and output
# Chapter 1: Introduction to Advanced PowerShell Concepts
# PowerShell Advanced Cookbook - BPB Publications

# A PSProvider (PowerShell Provider) is a component that provides access to
# different data stores in a consistent, filesystem-like manner. This allows
# you to navigate registries, certificates, and other stores just like folders.

# View all available PSProviders on your system
Get-PSProvider

# Expected Output:
# Name                 Capabilities                            Drives
# ----                 ------------                            ------
# Registry             ShouldProcess                           {HKLM, HKCU}
# Alias                ShouldProcess                           {Alias}
# Environment          ShouldProcess                           {Env}
# FileSystem           Filter, ShouldProcess, Credentials      {C, D, ...}
# Function             ShouldProcess                           {Function}
# Variable             ShouldProcess                           {Variable}
# Certificate          ShouldProcess                           {Cert}
# WSMan                Credentials                             {WSMan}

# Understanding Provider Capabilities:
# - ShouldProcess: Supports -WhatIf and -Confirm parameters for safe operations
# - Filter: Supports the -Filter parameter for efficient server-side filtering
# - Credentials: Supports alternate credentials via -Credential parameter

# Get details about a specific provider by name
Get-PSProvider -PSProvider FileSystem

# Expected Output:
# Name                 Capabilities                            Drives
# ----                 ------------                            ------
# FileSystem           Filter, ShouldProcess, Credentials      {C, D, ...}

# View which drives are available for each provider
Get-PSProvider | Select-Object Name, Drives

# Expected Output:
# Name        Drives
# ----        ------
# Registry    {HKLM, HKCU}
# Alias       {Alias}
# Environment {Env}
# FileSystem  {C, D, E}
# Function    {Function}
# Variable    {Variable}
# Certificate {Cert}
# WSMan       {WSMan}

# List all PSDrives (the actual drive letters/names you can navigate to)
Get-PSDrive

# Filter PSDrives by provider - show only Registry drives
Get-PSDrive -PSProvider Registry

# Expected Output:
# Name  Used (GB)  Free (GB)  Provider   Root              CurrentLocation
# ----  ---------  ---------  --------   ----              ---------------
# HKCU                        Registry   HKEY_CURRENT_USER
# HKLM                        Registry   HKEY_LOCAL_MACHINE

# Tip: You can navigate to any PSDrive using Set-Location (cd)
# For example: Set-Location HKCU:\ or Set-Location Cert:\
