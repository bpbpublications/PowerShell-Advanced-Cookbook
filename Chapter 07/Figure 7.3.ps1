# Figure 7.3 - Create Test Fixture with New-Fixture
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates using New-Fixture to scaffold a script and its test file.

# ============================================================================
# CREATE TEST FIXTURE
# ============================================================================

# New-Fixture creates two files:
# 1. MyScript.ps1 - The main script file (empty function template)
# 2. MyScript.Tests.ps1 - The test file with Pester structure
# Requires Pester 5.5.0 or later
New-Fixture -Name MyScript

# Expected Output:
# Directory: C:\YourPath
#
# Mode                 LastWriteTime         Length Name
# ----                 -------------         ------ ----
# -a---           1/15/2024  10:00 AM            100 MyScript.ps1
# -a---           1/15/2024  10:00 AM            250 MyScript.Tests.ps1

# ============================================================================
# VIEW GENERATED FILES
# ============================================================================

# View the content of the main script file
Get-Content MyScript.ps1

# Expected Output:
# function MyScript {
#
# }

# View the content of the test file
Get-Content MyScript.Tests.ps1

# Expected Output:
# BeforeAll {
#     . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
# }
#
# Describe "MyScript" {
#     It "Returns expected output" {
#         MyScript | Should -Be "YOUR_EXPECTED_VALUE"
#     }
# }

# Note: The BeforeAll block dot-sources the main script,
# making its functions available in the test context
