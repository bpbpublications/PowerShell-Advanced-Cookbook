#!/usr/bin/env pwsh
# Figure 5.10 - Cross-Platform Script with Platform Detection
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates writing cross-platform scripts using automatic variables
# $IsWindows, $IsLinux, and $IsMacOS to detect the operating system.

[CmdletBinding()]
param (
    # Filename for the output info file
    [Parameter(Mandatory = $true)]
    [String]$FileName
)

# ============================================================================
# PLATFORM DETECTION
# ============================================================================

# PowerShell 6+ provides automatic variables for platform detection:
# - $IsWindows: True on Windows
# - $IsLinux: True on Linux
# - $IsMacOS: True on macOS
# These are NOT available in Windows PowerShell 5.1

switch ($true) {
    { $IsWindows } {
        # Code specific to Windows
        Write-Output "This platform is Windows"
        $TempPath = Join-Path "C:" "Temp"
    }
    { $IsLinux } {
        # Code specific to Linux
        Write-Output "This platform is Linux"
        $TempPath = Join-Path "/" "home" "Temp"
    }
    { $IsMacOS } {
        # Code specific to MacOS
        Write-Output "This platform is MacOS"
        $TempPath = Join-Path "/" "home" "Temp"
    }
    default {
        exit "This platform is Unsupported"
    }
}

# ============================================================================
# GATHER SYSTEM INFORMATION
# ============================================================================

# Build full path using Join-Path for cross-platform compatibility
$InfoFile = Join-Path $TempPath $FileName

# Create a custom object with system information
$Info = [PSCustomObject]@{
    OS                    = ($PSVersionTable).OS
    Platform              = ($PSVersionTable).Platform
    PSVersion             = (($PSVersionTable).PSVersion).ToString()
    "Get-ChildItem-Alias" = (Get-Alias -Definition Get-ChildItem).DisplayName
}

# ============================================================================
# SAVE TO FILE
# ============================================================================

# Convert to JSON and save (creates directory if needed)
$Info | ConvertTo-Json | Out-File $InfoFile -Force

# ============================================================================
# EXPECTED OUTPUT (Linux)
# ============================================================================

# This platform is Linux
#
# Contents of /home/Temp/info.json:
# {
#   "OS": "Linux 5.15.0-1024-azure #30-Ubuntu SMP...",
#   "Platform": "Unix",
#   "PSVersion": "7.4.0",
#   "Get-ChildItem-Alias": "dir -> Get-ChildItem, gci -> Get-ChildItem, ls -> Get-ChildItem"
# }

# ============================================================================
# EXPECTED OUTPUT (Windows)
# ============================================================================

# This platform is Windows
#
# Contents of C:\Temp\info.json:
# {
#   "OS": "Microsoft Windows 10.0.22621",
#   "Platform": "Win32NT",
#   "PSVersion": "7.4.0",
#   "Get-ChildItem-Alias": "dir -> Get-ChildItem, gci -> Get-ChildItem, ls -> Get-ChildItem"
# }

# ============================================================================
# CROSS-PLATFORM BEST PRACTICES
# ============================================================================

# PATH HANDLING:
# - Always use Join-Path instead of string concatenation
# - Use [System.IO.Path]::DirectorySeparatorChar if needed
# - Avoid hardcoded path separators (\ vs /)

# ENVIRONMENT VARIABLES:
# - $env:HOME works on Linux/macOS
# - $env:USERPROFILE works on Windows
# - Use $HOME (automatic variable) for cross-platform home directory

# ALIASES:
# - Some aliases differ by platform
# - 'ls' conflicts with native Linux command
# - Use full cmdlet names for reliability

# ============================================================================
# USAGE
# ============================================================================

# ./Figure 5.10.ps1 -FileName "sysinfo.json"

