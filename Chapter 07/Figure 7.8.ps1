# Figure 7.8 - Pester Test Structure with Describe, Context, and It
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates Pester test organization with Describe, Context, and It blocks.

# ============================================================================
# EXAMPLE FUNCTION: Blend-Colors
# ============================================================================

# This function blends two colors and returns the result
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
#             return "Purple" }
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
# PESTER TEST STRUCTURE
# ============================================================================

# Describe: Groups related tests (typically for one function or feature)
# -Tag: Allows filtering tests by tag when running
# Context: Groups tests within a Describe block by scenario
# It: Defines an individual test case

# Describe -Tag "Colors" "Blend-Colors" {
#
#     Context "Test Valid color combinations" {
#         It "Blue and Red should be Purple" {
#             $Color = Blend-Colors "Blue" "Red"
#             $Color | Should -Be "Purple"
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
#
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

# Load configuration from external file if available
. ..\PesterConfigs\PesterConfig-Detailed.ps1

# Run the tests
Invoke-Pester -Configuration $PesterConfig

# Expected Output (all tests pass):
# Describing Blend-Colors
#   Context Test Valid color combinations
#     [+] Blue and Red should be Purple
#     [+] Red and Green should be Brown
#     [+] Blue and Green should be Teal
#   Context Test unsupported color Combinations
#     [+] Black and White should be Unsupported
#     [+] Green and Yellow should be Unsupported
# Tests Passed: 5, Failed: 0, Skipped: 0
