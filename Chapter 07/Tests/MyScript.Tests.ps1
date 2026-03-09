# Recipe: Testing Color Blending Function
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates Pester test organization with tags for filtering test execution.

# ============================================================================
# TEST SETUP
# ============================================================================

# BeforeAll runs once before any tests in this file
# Dot-source the script containing the function under test
BeforeAll {
    # This pattern replaces .Tests.ps1 with .ps1 to find the source file
    # MyScript.Tests.ps1 -> MyScript.ps1
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

# ============================================================================
# VALID COLOR COMBINATION TESTS
# ============================================================================

# The -Tag parameter allows filtering tests by category
# Run only valid tests: Invoke-Pester -Tag "Valid"
Describe -Tag "Valid" "Blend-Colors" {

    Context "Test Valid Color combinations" {

        It "Blue and Red should be Purple" {
            $Color = Blend-Colors "Blue" "Red"
            $Color | Should -Be "Purple"
        }

        It "Red and Green should be Brown" {
            $Color = Blend-Colors "Red" "Green"
            $Color | Should -Be "Brown"
        }

        It "Blue and Green should be Teal" {
            $Color = Blend-Colors "Blue" "Green"
            $Color | Should -Be "Teal"
        }
    }
}

# ============================================================================
# UNSUPPORTED COLOR COMBINATION TESTS
# ============================================================================

# Run only unsupported tests: Invoke-Pester -Tag "Unsupported"
Describe -Tag "Unsupported" "Blend-Colors" {

    Context "Test unsupported Color Combinations" {

        It "Black and White should be Unsupported" {
            $Color = Blend-Colors "Black" "White"
            $Color | Should -Be "Unsupported Color Combination"
        }

        It "Green and Yellow should be Unsupported" {
            $Color = Blend-Colors "Green" "Yellow"
            $Color | Should -Be "Unsupported Color Combination"
        }
    }
}

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Running all tests:
# Invoke-Pester -Path .\MyScript.Tests.ps1
#
# Expected Output:
# Describing Blend-Colors
#   Context Test Valid Color combinations
#     [+] Blue and Red should be Purple
#     [+] Red and Green should be Brown
#     [+] Blue and Green should be Teal
#   Context Test unsupported Color Combinations
#     [+] Black and White should be Unsupported
#     [+] Green and Yellow should be Unsupported
# Tests Passed: 5, Failed: 0, Skipped: 0

# Running only valid tests:
# $Config = New-PesterConfiguration
# $Config.Filter.Tag = "Valid"
# Invoke-Pester -Configuration $Config
