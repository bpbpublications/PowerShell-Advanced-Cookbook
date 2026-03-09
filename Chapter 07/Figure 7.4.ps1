# Figure 7.4 - Run Pester Tests
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates invoking Pester tests on a specific test file.

# ============================================================================
# INVOKE PESTER TESTS
# ============================================================================

# Invoke-Pester runs tests from the specified test file
# -Path specifies the test file or directory to run
Invoke-Pester -Path .\MyScript.Tests.ps1

# Expected Output (when tests pass):
# Starting discovery in 1 files.
# Discovery found 1 tests in 15ms.
# Running tests.
# [+] C:\Path\MyScript.Tests.ps1 45ms (12ms|33ms)
# Tests completed in 60ms
# Tests Passed: 1, Failed: 0, Skipped: 0

# Expected Output (when tests fail):
# Starting discovery in 1 files.
# Discovery found 1 tests in 15ms.
# Running tests.
# [-] C:\Path\MyScript.Tests.ps1 45ms (12ms|33ms)
#   [-] Describe.It "Returns expected output" 30ms (28ms|2ms)
#    Expected 'YOUR_EXPECTED_VALUE', but got 'actual_value'.
# Tests completed in 60ms
# Tests Passed: 0, Failed: 1, Skipped: 0

# ============================================================================
# ADDITIONAL OPTIONS
# ============================================================================

# Run all tests in current directory recursively:
# Invoke-Pester

# Run with detailed output:
# Invoke-Pester -Path .\MyScript.Tests.ps1 -Output Detailed

# Run and output results to file:
# Invoke-Pester -Path .\MyScript.Tests.ps1 -OutputFile TestResults.xml
