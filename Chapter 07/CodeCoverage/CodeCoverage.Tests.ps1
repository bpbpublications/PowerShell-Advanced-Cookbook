# Recipe: Code Coverage Tests - 100% Coverage Example
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates achieving 100% code coverage by testing all code paths.

# ============================================================================
# TEST SETUP
# ============================================================================

# BeforeAll runs once before any tests in this file
BeforeAll {
    # Dot-source the functions under test
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

# ============================================================================
# TESTS FOR FUNCTIONS ONE AND TWO
# ============================================================================

Describe "CodeCoverage" {

    # -------------------------------------------------------------------------
    # Function One Tests - Both if and else branches
    # -------------------------------------------------------------------------
    Context "It tests function One" {

        # Test the if ($Parameter) branch - returns "Parameter is true"
        It "Should return: Parameter is true" {
            One $true | Should -Be "Parameter is true"
        }

        # Test the else branch - returns "Parameter is false"
        It "Should return: Parameter is false" {
            One $false | Should -Be "Parameter is false"
        }
    }

    # -------------------------------------------------------------------------
    # Function Two Tests - Both try success and catch paths
    # -------------------------------------------------------------------------
    Context "It tests function Two" {

        # Test the throw path - triggers catch block
        It "Should return Failed" {
            Two $true | Should -Be "Failed"
        }

        # Test the success path - no exception thrown
        It "Should return Success" {
            Two $false | Should -Be "Success"
        }
    }
}

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Running tests without code coverage:
# Invoke-Pester -Path .\CodeCoverage.Tests.ps1
#
# Expected Output:
# Describing CodeCoverage
#   Context It tests function One
#     [+] Should return: Parameter is true
#     [+] Should return: Parameter is false
#   Context It tests function Two
#     [+] Should return Failed
#     [+] Should return Success
# Tests Passed: 4, Failed: 0, Skipped: 0

# ============================================================================
# RUNNING WITH CODE COVERAGE
# ============================================================================

# To run with code coverage analysis:
# $Config = New-PesterConfiguration
# $Config.Output.Verbosity = "Detailed"
# $Config.CodeCoverage.Enabled = $true
# $Config.CodeCoverage.Path = ".\CodeCoverage.ps1"
# $Config.CodeCoverage.CoveragePercentTarget = 85
# Invoke-Pester -Configuration $Config
#
# Expected Code Coverage Output:
# Code Coverage:
#   Covered: 100.00% (above 85.00% target)
#   Commands: 8 executed, 0 missed
#   All code paths tested!

# ============================================================================
# WHY 100% COVERAGE MATTERS
# ============================================================================

# Benefits of complete code coverage:
# - All code paths are verified to work correctly
# - Edge cases and error handling are tested
# - Regressions will be caught by failing tests
# - Confidence in code quality and reliability
#
# Note: 100% coverage doesn't guarantee bug-free code,
# but it does ensure all code paths have been executed at least once.
