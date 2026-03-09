# Figure 7.11 - Filter Tests by Tag
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 7+)
# Demonstrates filtering Pester tests by tag to run platform-specific tests.

# ============================================================================
# CROSS-PLATFORM FUNCTIONS (REFERENCE)
# ============================================================================

# function Linux-String { return "I am a Linux String" }
# function Windows-String { return "I am a Windows String" }
# function MacOS-String { return "I am a MacOS String" }
# function Linux-RootPath { return "/" }
# function Windows-RootPath { return "c:\" }
# function MacOS-RootPath { return "/" }
# function Linux-Other { sudo apt-get update && sudo apt-get upgrade }
# function Windows-Other { Get-PSDrive WSMan }
# function MacOS-Other { sw_vers -productVersion }

# ============================================================================
# PLATFORM-TAGGED TEST CASES (REFERENCE)
# ============================================================================

# Tests are tagged with platform names: "Linux", "Windows", "MacOS"
# See Figure 7.10 for full test definitions

# Describe -Tag "Linux" "Linux Tests - Platform independent" { ... }
# Describe -Tag "Linux" "Linux Tests - Platform dependent" { ... }
# Describe -Tag "Windows" "Windows Tests - Platform independent" { ... }
# Describe -Tag "Windows" "Windows Tests - Platform dependent" { ... }
# Describe -Tag "MacOS" "MacOS Tests - Platform independent" { ... }
# Describe -Tag "MacOS" "MacOS Tests - Platform dependent" { ... }

# ============================================================================
# RUN ONLY WINDOWS TESTS
# ============================================================================

$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

# Filter.Tag runs only tests with matching tags
# This runs only the Windows-tagged tests
$PesterConfig.Filter.Tag = "Windows"

Invoke-Pester -Configuration $PesterConfig

# Expected Output:
# Describing Windows Tests - Platform independent
#   Context Strings
#     [+] Must be a Windows String
#   Context Paths
#     [+] Must be the Root Path
# Describing Windows Tests - Platform dependent
#   [+] Must not throw an error
# Tests Passed: 3, Failed: 0, Skipped: 0

# Note: Linux and MacOS tests are NOT run because they don't have "Windows" tag

# ============================================================================
# RUN MULTIPLE PLATFORM TESTS
# ============================================================================

# To run tests for multiple platforms:
# $PesterConfig.Filter.Tag = "Linux", "MacOS"
# This would run both Linux and MacOS tests, but not Windows tests
