# Figure 7.10 - Cross-Platform Testing with Tags
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 7+)
# Demonstrates organizing tests by platform using Pester tags.

# ============================================================================
# CROSS-PLATFORM FUNCTIONS
# ============================================================================

# These functions demonstrate platform-specific behavior
# In real scenarios, these would contain actual platform-specific logic

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
# PLATFORM-TAGGED TEST CASES
# ============================================================================

# Using -Tag allows filtering tests by platform
# Run only Windows tests: $PesterConfig.Filter.Tag = "Windows"

# Describe -Tag "Linux" "Linux Tests - Platform independent" {
#     Context "Strings" {
#         It "Must be a Linux String" {
#             $String = Linux-String
#             $String | Should -Be "I am a Linux String"
#         }
#     }
#     Context "Paths" {
#         It "Must be the Root Path" {
#             $Path = Linux-RootPath
#             $Path | Should -Be "/"
#         }
#     }
# }

# Describe -Tag "Linux" "Linux Tests - Platform dependent" {
#     It "Must not throw an error" {
#         $Other = Linux-Other
#         { $Other } | Should -Not -Throw
#     }
# }

# Describe -Tag "Windows" "Windows Tests - Platform independent" {
#     Context "Strings" {
#         It "Must be a Windows String" {
#             $String = Windows-String
#             $String | Should -Be "I am a Windows String"
#         }
#     }
#     Context "Paths" {
#         It "Must be the Root Path" {
#             $Path = Windows-RootPath
#             $Path | Should -Be "C:\"
#         }
#     }
# }

# Describe -Tag "Windows" "Windows Tests - Platform dependent" {
#     It "Must not throw an error" {
#         $Other = Windows-Other
#         { $Other } | Should -Not -Throw
#     }
# }

# Describe -Tag "MacOS" "MacOS Tests - Platform independent" {
#     Context "Strings" {
#         It "Must be a MacOS String" {
#             $String = MacOS-String
#             $String | Should -Be "I am a MacOS String"
#         }
#     }
#     Context "Paths" {
#         It "Must be the Root Path" {
#             $Path = MacOS-RootPath
#             $Path | Should -Be "/"
#         }
#     }
# }

# Describe -Tag "MacOS" "MacOS Tests - Platform dependent" {
#     It "Must not throw an error" {
#         $Other = MacOS-Other
#         { $Other } | Should -Not -Throw
#     }
# }

# ============================================================================
# RUN ALL TESTS (NO FILTER)
# ============================================================================

$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

Invoke-Pester -Configuration $PesterConfig

# Expected Output: All platform tests run
# Tests for Linux, Windows, and MacOS are all executed
