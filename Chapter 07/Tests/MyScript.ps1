# Recipe: Color Blending Function
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates a testable function with multiple code paths for Pester testing.

# ============================================================================
# FUNCTION UNDER TEST
# ============================================================================

function Blend-Colors {
    <#
    .SYNOPSIS
        Blends two primary colors and returns the resulting secondary color.

    .DESCRIPTION
        This function takes two color names as input and returns the secondary
        color produced by blending them. Uses regex switch for bidirectional
        color matching (Red Blue = Blue Red = Purple).

    .PARAMETER Color1
        The first color to blend.

    .PARAMETER Color2
        The second color to blend.

    .EXAMPLE
        Blend-Colors -Color1 "Red" -Color2 "Blue"
        # Returns: Purple

    .EXAMPLE
        Blend-Colors "Green" "Blue"
        # Returns: Teal
    #>
    [CmdletBinding()]
    param (
        [String]$Color1,
        [String]$Color2
    )

    # Log input for debugging when -Verbose is used
    Write-Verbose "Input colors: $Color1 and $Color2"

    # Use regex switch to match color combinations in either order
    # The pattern "Red Blue|Blue Red" matches regardless of parameter order
    switch -Regex ("$Color1 $Color2") {
        "Red Blue|Blue Red" {
            Write-Verbose "Output color: Purple"
            return "Purple"
        }
        "Red Green|Green Red" {
            Write-Verbose "Output color: Brown"
            return "Brown"
        }
        "Blue Green|Green Blue" {
            Write-Verbose "Output color: Teal"
            return "Teal"
        }
        default {
            # Handle unsupported color combinations gracefully
            return "Unsupported Color Combination"
        }
    }
}

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

# Test the function manually:
# Blend-Colors "Red" "Blue"           # Returns: Purple
# Blend-Colors "Blue" "Red"           # Returns: Purple (order doesn't matter)
# Blend-Colors "Red" "Green"          # Returns: Brown
# Blend-Colors "Blue" "Green"         # Returns: Teal
# Blend-Colors "Black" "White"        # Returns: Unsupported Color Combination

# With verbose output:
# Blend-Colors "Red" "Blue" -Verbose

# Run the Pester tests:
# Invoke-Pester -Path .\MyScript.Tests.ps1
