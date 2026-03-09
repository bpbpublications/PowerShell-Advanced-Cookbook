# Recipe: Platform-Specific Functions for Test Organization Demo
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# These functions demonstrate organizing tests by platform using Pester tags.

# ============================================================================
# PLATFORM IDENTIFICATION FUNCTIONS
# ============================================================================

# These functions return platform-specific strings
# Used to demonstrate grouping tests by platform with tags

function Linux-String {
    <#
    .SYNOPSIS
        Returns a Linux platform identifier string.
    #>
    return "I am a Linux String"
}

function Windows-String {
    <#
    .SYNOPSIS
        Returns a Windows platform identifier string.
    #>
    return "I am a Windows String"
}

function MacOS-String {
    <#
    .SYNOPSIS
        Returns a macOS platform identifier string.
    #>
    return "I am a MacOS String"
}

# ============================================================================
# PLATFORM ROOT PATH FUNCTIONS
# ============================================================================

# These functions return the root filesystem path for each platform

function Linux-RootPath {
    <#
    .SYNOPSIS
        Returns the Linux filesystem root path.
    #>
    return "/"
}

function Windows-RootPath {
    <#
    .SYNOPSIS
        Returns the Windows filesystem root path.
    #>
    return "c:\"
}

function MacOS-RootPath {
    <#
    .SYNOPSIS
        Returns the macOS filesystem root path.
    #>
    return "/"
}

# ============================================================================
# USAGE
# ============================================================================

# These functions are used by Organization.Tests.ps1 to demonstrate:
# 1. Grouping tests by platform using -Tag parameter
# 2. Running platform-specific tests with tag filtering
# 3. Organizing related tests in Context blocks

# Run all tests:
# Invoke-Pester -Path .\Organization.Tests.ps1

# Run only Windows tests:
# $Config = New-PesterConfiguration
# $Config.Filter.Tag = "Windows"
# Invoke-Pester -Configuration $Config

# Run Linux and MacOS tests:
# $Config = New-PesterConfiguration
# $Config.Filter.Tag = "Linux", "MacOS"
# Invoke-Pester -Configuration $Config
