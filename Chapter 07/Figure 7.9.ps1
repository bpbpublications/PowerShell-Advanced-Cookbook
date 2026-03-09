# Figure 7.9 - Detecting Test Failures with Pester
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates how Pester catches bugs when code changes break tests.

# ============================================================================
# EXAMPLE FUNCTION WITH BUG (INTENTIONAL TYPO)
# ============================================================================

# This version has a bug: "Purple" is misspelled as "Purpl"
# This simulates what happens when code changes introduce regressions

# function Blend-Colors {
#     [CmdletBinding()]
#     param (
#         [String]$Color1,
#         [String]$Color2
#     )
#     Write-Verbose "Input colors: $Color1 and $Color2"
#     switch -Regex ("$Color1 $Color2") {
#         "Red Blue|Blue Red" {
#             Write-Verbose "Output color: Purple"
#             return "Purpl" }   # <-- BUG: Missing 'e' in Purple
#         "Red Green|Green Red" {
#             Write-Verbose "Output color: Brown"
#             return "Brown" }
#         "Blue Green|Green Blue" {
#             Write-Verbose "Output color: Teal"
#             return "Teal" }
#         default { return "Unsupported Color Combination" }
#     }
# }

# ============================================================================
# PESTER TESTS (SAME AS BEFORE)
# ============================================================================

# Describe -Tag "Colors" "Blend-Colors" {
#     Context "Test Valid color combinations" {
#         It "Blue and Red should be Purple" {
#             $Color = Blend-Colors "Blue" "Red"
#             $Color | Should -Be "Purple"  # This will FAIL
#         }
#         It "Red and Green should be Brown" {
#             $Color = Blend-Colors "Red" "Green"
#             $Color | Should -Be "Brown"
#         }
#         It "Blue and Green should be Teal" {
#             $Color = Blend-Colors "Blue" "Green"
#             $Color | Should -Be "Teal"
#         }
#     }
#     Context "Test unsupported color Combinations" {
#         It "Black and White should be Unsupported" {
#             $Color = Blend-Colors "Black" "White"
#             $Color | Should -Be "Unsupported Color Combination"
#         }
#         It "Green and Yellow should be Unsupported" {
#             $Color = Blend-Colors "Green" "Yellow"
#             $Color | Should -Be "Unsupported Color Combination"
#         }
#     }
# }

# ============================================================================
# RUN THE TESTS
# ============================================================================

$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

. ..\PesterConfigs\PesterConfig-Detailed.ps1

Invoke-Pester -Configuration $PesterConfig

# Expected Output (test failure detected):
# Describing Blend-Colors
#   Context Test Valid color combinations
#     [-] Blue and Red should be Purple
#       Expected strings to be the same, but they were different.
#       Expected: 'Purple'
#       But was:  'Purpl'
#     [+] Red and Green should be Brown
#     [+] Blue and Green should be Teal
#   Context Test unsupported color Combinations
#     [+] Black and White should be Unsupported
#     [+] Green and Yellow should be Unsupported
# Tests Passed: 4, Failed: 1, Skipped: 0

# The failed test shows exactly what was expected vs. what was returned,
# making it easy to identify and fix the bug
