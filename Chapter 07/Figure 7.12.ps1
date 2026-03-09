# Figure 7.12 - Filter Tests by Name Pattern
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 7+)
# Demonstrates filtering Pester tests by Describe block name using wildcards.

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

# Tests have Describe blocks with names like:
# - "Linux Tests - Platform independent"
# - "Linux Tests - Platform dependent"
# - "Windows Tests - Platform independent"
# - "Windows Tests - Platform dependent"
# - "MacOS Tests - Platform independent"
# - "MacOS Tests - Platform dependent"

# See Figure 7.10 for full test definitions

# ============================================================================
# RUN ONLY PLATFORM-INDEPENDENT TESTS
# ============================================================================

$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

# Filter.FullName uses wildcard matching on Describe block names
# "* independent" matches any Describe block ending with "independent"
$PesterConfig.Filter.FullName = "* independent"

Invoke-Pester -Configuration $PesterConfig

# Expected Output:
# Describing Linux Tests - Platform independent
#   Context Strings
#     [+] Must be a Linux String
#   Context Paths
#     [+] Must be the Root Path
# Describing Windows Tests - Platform independent
#   Context Strings
#     [+] Must be a Windows String
#   Context Paths
#     [+] Must be the Root Path
# Describing MacOS Tests - Platform independent
#   Context Strings
#     [+] Must be a MacOS String
#   Context Paths
#     [+] Must be the Root Path
# Tests Passed: 6, Failed: 0, Skipped: 0

# Note: "Platform dependent" tests are skipped because they don't match the pattern

# ============================================================================
# FILTER BY MULTIPLE PATTERNS
# ============================================================================

# You can also specify multiple exact names:
# $PesterConfig.Filter.FullName = @(
#     "Linux Tests - Platform independent",
#     "Windows Tests - Platform independent"
# )
