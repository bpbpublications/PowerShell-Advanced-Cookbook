# Recipe: Functions for Code Coverage Demonstration
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# These functions demonstrate Pester code coverage analysis with multiple code paths.

# ============================================================================
# FUNCTION ONE - BOOLEAN PARAMETER WITH IF/ELSE
# ============================================================================

function One {
    <#
    .SYNOPSIS
        Returns different strings based on boolean parameter value.

    .DESCRIPTION
        This function demonstrates a simple if/else branch that requires
        two tests to achieve 100% code coverage:
        - One test with $true to cover the if branch
        - One test with $false to cover the else branch

    .PARAMETER Parameter
        Boolean value that determines which branch executes.

    .EXAMPLE
        One $true   # Returns: "Parameter is true"
        One $false  # Returns: "Parameter is false"
    #>
    param (
        [Bool]$Parameter
    )

    if ($Parameter) {
        return "Parameter is true"
    }
    else {
        return "Parameter is false"
    }
}

# ============================================================================
# FUNCTION TWO - TRY/CATCH WITH CONDITIONAL THROW
# ============================================================================

function Two {
    <#
    .SYNOPSIS
        Demonstrates try/catch with conditional exception throwing.

    .DESCRIPTION
        This function requires two tests for 100% code coverage:
        - One test with $true to trigger the throw and catch block
        - One test with $false to execute the success path

    .PARAMETER Parameter
        When $true, throws an exception. When $false, returns "Success".

    .EXAMPLE
        Two $true   # Returns: "Failed" (caught exception message)
        Two $false  # Returns: "Success"
    #>
    param (
        [Bool]$Parameter = $false
    )

    try {
        if ($Parameter) {
            # This line requires a test with $true to be covered
            throw "Failed"
        }
        # This line requires a test with $false to be covered
        $Output = "Success"
    }
    catch {
        # The catch block is covered when throw is triggered
        $Output = "$_"
    }

    return $Output
}

# ============================================================================
# CODE COVERAGE ANALYSIS
# ============================================================================

# To run tests with code coverage:
# $Config = New-PesterConfiguration
# $Config.CodeCoverage.Enabled = $true
# $Config.CodeCoverage.Path = ".\CodeCoverage.ps1"
# $Config.CodeCoverage.CoveragePercentTarget = 85
# Invoke-Pester -Configuration $Config

# With incomplete tests (only testing $true cases):
# - Function One: 50% covered (only if branch tested)
# - Function Two: ~66% covered (throw and catch tested, not success path)
# - Overall: ~75% coverage

# With complete tests (testing both $true and $false cases):
# - Function One: 100% covered (both branches tested)
# - Function Two: 100% covered (both paths tested)
# - Overall: 100% coverage
