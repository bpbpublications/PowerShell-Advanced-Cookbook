# Figure 7.18 - Code Coverage with Pester (100% Coverage)
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates achieving 100% code coverage with comprehensive tests.

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
# TESTS WITH COMPLETE COVERAGE (100%)
# ============================================================================

# These tests cover ALL code paths:
# - Function One: Tests both $true and $false paths
# - Function Two: Tests both success and throw paths

# Describe "CodeCoverage" {
#     Context "It tests function One" {
#         It "Should return: Parameter is true" {
#             One $true | Should -Be "Parameter is true"
#         }
#         It "Should return: Parameter is false" {
#             One $false | Should -Be "Parameter is false"
#         }
#     }
#     Context "It tests function Two" {
#         It "Should return Failed" {
#             Two $true | Should -Be "Failed"
#         }
#         It "Should return Success" {
#             Two $false | Should -Be "Success"
#         }
#     }
# }

# ============================================================================
# RUN TESTS WITH CODE COVERAGE
# ============================================================================

$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

# Enable code coverage analysis
$PesterConfig.CodeCoverage.Enabled = $true

# Set target coverage percentage
$PesterConfig.CodeCoverage.CoveragePercentTarget = 85

Invoke-Pester -Configuration $PesterConfig

# Expected Output:
# Describing CodeCoverage
#   Context It tests function One
#     [+] Should return: Parameter is true
#     [+] Should return: Parameter is false
#   Context It tests function Two
#     [+] Should return Failed
#     [+] Should return Success
# Tests Passed: 4, Failed: 0, Skipped: 0
#
# Code Coverage:
#   Covered: 100.00% (above 85.00% target)
#   All commands covered!

# Benefits of 100% coverage:
# - All code paths are tested
# - Confidence that all logic works correctly
# - Regressions will be caught by failing tests
