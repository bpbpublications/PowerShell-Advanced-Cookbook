# Recipe: Test Organization with Platform Tags
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates organizing tests by platform using Pester tags and Context blocks.

# ============================================================================
# TEST SETUP
# ============================================================================

# BeforeAll runs once before any tests in this file
BeforeAll {
    # Dot-source the functions under test
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

# ============================================================================
# LINUX PLATFORM TESTS
# ============================================================================

# Tag allows filtering: Invoke-Pester -Tag "Linux"
Describe -Tag "Linux" "Linux Tests" {

    Context "Strings" {
        It "Must be a Linux String" {
            $String = Linux-String
            $String | Should -Be "I am a Linux String"
        }
    }

    Context "Paths" {
        It "Must be the Root Path" {
            $Path = Linux-RootPath
            $Path | Should -Be "/"
        }
    }
}

# ============================================================================
# WINDOWS PLATFORM TESTS
# ============================================================================

# Tag allows filtering: Invoke-Pester -Tag "Windows"
Describe -Tag "Windows" "Windows Tests" {

    Context "Strings" {
        It "Must be a Windows String" {
            $String = Windows-String
            $String | Should -Be "I am a Windows String"
        }
    }

    Context "Paths" {
        It "Must be the Root Path" {
            $Path = Windows-RootPath
            $Path | Should -Be "C:\"
        }
    }
}

# ============================================================================
# MACOS PLATFORM TESTS
# ============================================================================

# Note: No tag on this Describe block - runs with all tests
# To add a tag: Describe -Tag "MacOS" "MacOS Tests"
Describe "MacOS Tests" {

    Context "Strings" {
        It "Must be a MacOS String" {
            $String = MacOS-String
            $String | Should -Be "I am a MacOS String"
        }
    }

    Context "Paths" {
        It "Must be the Root Path" {
            $Path = MacOS-RootPath
            $Path | Should -Be "/"
        }
    }
}

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Running all tests:
# Invoke-Pester -Path .\Organization.Tests.ps1
#
# Expected Output:
# Describing Linux Tests
#   Context Strings
#     [+] Must be a Linux String
#   Context Paths
#     [+] Must be the Root Path
# Describing Windows Tests
#   Context Strings
#     [+] Must be a Windows String
#   Context Paths
#     [+] Must be the Root Path
# Describing MacOS Tests
#   Context Strings
#     [+] Must be a MacOS String
#   Context Paths
#     [+] Must be the Root Path
# Tests Passed: 6, Failed: 0, Skipped: 0

# ============================================================================
# FILTERING BY TAG
# ============================================================================

# Run only Linux tests:
# $Config = New-PesterConfiguration
# $Config.Filter.Tag = "Linux"
# Invoke-Pester -Configuration $Config
#
# Run Linux and Windows tests:
# $Config = New-PesterConfiguration
# $Config.Filter.Tag = "Linux", "Windows"
# Invoke-Pester -Configuration $Config
