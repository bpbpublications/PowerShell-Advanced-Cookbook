#!/usr/bin/env pwsh
# Figure 5.11 - Cross-Platform Script (Alternative View)
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This is a compact view of the cross-platform script from Figure 5.10.
# It demonstrates platform detection without the verbose output.

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]$FileName
)

# ============================================================================
# PLATFORM DETECTION
# ============================================================================

# Use the automatic variables to determine which platform we're running on
# Note: These are only available in PowerShell 6+, not Windows PowerShell 5.1
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
# GATHER AND SAVE SYSTEM INFO
# ============================================================================

$InfoFile = Join-Path $TempPath $FileName

# Build a custom object with platform information
$Info = [PSCustomObject]@{
    OS                    = ($PSVersionTable).OS
    Platform              = ($PSVersionTable).Platform
    PSVersion             = (($PSVersionTable).PSVersion).ToString()
    "Get-ChildItem-Alias" = (Get-Alias -Definition Get-ChildItem).DisplayName
}

# Export as JSON
$Info | ConvertTo-Json | Out-File $InfoFile -Force

# ============================================================================
# USAGE
# ============================================================================

# ./Figure 5.11.ps1 -FileName "platforminfo.json"
#
# Expected Output (Linux):
# This platform is Linux
# (Creates /home/Temp/platforminfo.json)

