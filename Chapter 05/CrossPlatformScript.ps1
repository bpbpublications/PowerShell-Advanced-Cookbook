#!/usr/bin/env pwsh
# Recipe: Cross-Platform PowerShell Script
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates writing scripts that work on Windows, Linux, and macOS
# using platform detection with automatic variables.

[CmdletBinding()]
param (
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
# Note: These are NOT available in Windows PowerShell 5.1

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

# Build the full path using Join-Path for cross-platform compatibility
$InfoFile = Join-Path $TempPath $FileName

# Create a custom object with platform information
$Info = [PSCustomObject]@{
    OS                    = ($PSVersionTable).OS
    Platform              = ($PSVersionTable).Platform
    PSVersion             = (($PSVersionTable).PSVersion).ToString()
    "Get-ChildItem-Alias" = (Get-Alias -Definition Get-ChildItem).DisplayName
}

# ============================================================================
# SAVE TO FILE
# ============================================================================

$Info | ConvertTo-Json | Out-File $InfoFile -Force

# ============================================================================
# EXPECTED OUTPUT (Linux)
# ============================================================================

# This platform is Linux
#
# File contents:
# {
#   "OS": "Linux 5.15.0-1024-azure...",
#   "Platform": "Unix",
#   "PSVersion": "7.4.0",
#   "Get-ChildItem-Alias": "dir, gci, ls"
# }

# ============================================================================
# CROSS-PLATFORM BEST PRACTICES
# ============================================================================

# PATH HANDLING:
# - Use Join-Path instead of string concatenation
# - Use [System.IO.Path]::DirectorySeparatorChar for separator
# - Avoid hardcoded path separators (\ vs /)

# ENVIRONMENT VARIABLES:
# - $env:HOME works on Linux/macOS
# - $env:USERPROFILE works on Windows
# - Use $HOME automatic variable for cross-platform home directory

# LINE ENDINGS:
# - Windows uses CRLF (\r\n)
# - Linux/macOS use LF (\n)
# - Use [Environment]::NewLine for native line ending

# CASE SENSITIVITY:
# - Windows: Case-insensitive file system
# - Linux: Case-sensitive file system
# - Use consistent casing in file operations

# ============================================================================
# USAGE
# ============================================================================

# ./CrossPlatformScript.ps1 -FileName "sysinfo.json"

