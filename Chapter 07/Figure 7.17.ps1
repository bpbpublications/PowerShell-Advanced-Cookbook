# Figure 7.17 - Code Coverage with Pester (75% Coverage)
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates Pester code coverage reporting with incomplete test coverage.

# ============================================================================
# FUNCTIONS UNDER TEST
# ============================================================================

# function One {
#     param (
#         [Bool]$Parameter
#     )
#     if ($Parameter) {
#         return "Parameter is true"
#     }
#     else {
#         return "Parameter is false"
#     }
# }

# function Two {
#     param (
#         [Bool]$Parameter = $false
#     )
#     try {
#         if ($Parameter) {
#             throw "Failed"
#         }
#         $Output = "Success"
#     }
#     catch {
#         $Output = "$_"
#     }
#     return $Output
# }

# ============================================================================
# TESTS WITH INCOMPLETE COVERAGE (75%)
# ============================================================================

# These tests only cover some code paths:
# - Function One: Only tests $true path, not $false path
# - Function Two: Only tests throw path, not success path

# Describe "CodeCoverage" {
#     Context "It tests function One" {
#         It "Should return Parameter is true" {
#             One $true | Should -Be "Parameter is true"
#         }
#         # Missing: Test for $false case
#     }
#     Context "It tests function Two" {
#         It "Should return Failed" {
#             Two $true | Should -Be "Failed"
#         }
#         # Missing: Test for $false case (Success path)
#     }
# }

# ============================================================================
# RUN TESTS WITH CODE COVERAGE
# ============================================================================

$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

# Enable code coverage analysis
$PesterConfig.CodeCoverage.Enabled = $true

# Set target coverage percentage (will show warning if not met)
$PesterConfig.CodeCoverage.CoveragePercentTarget = 85

Invoke-Pester -Configuration $PesterConfig

# Expected Output:
# Describing CodeCoverage
#   Context It tests function One
#     [+] Should return Parameter is true
#   Context It tests function Two
#     [+] Should return Failed
# Tests Passed: 2, Failed: 0, Skipped: 0
#
# Code Coverage:
#   Covered: 75.00% (below 85.00% target)
#   Missed commands:
#     Function: One, Line: 8 (return "Parameter is false")
#     Function: Two, Line: 12 ($Output = "Success")
