# Recipe 2.1: Creating an Advanced Function
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates creating a complete advanced function with
# CmdletBinding, parameter validation, and structured output.

function Add-Superhero {
    # CmdletBinding enables advanced function features like -Verbose
    [CmdletBinding()]
    param (
        # Position allows positional parameters: Add-Superhero "Comet" instead of -Name "Comet"
        # Mandatory makes the parameter required
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$Name,

        # ValidateSet restricts input to predefined values
        [Parameter(Position = 1)]
        [ValidateSet("Flying", "Indestructible", "LaserEyes")]
        [String[]]$Abilities = "None",

        # ValidateRange restricts numeric values to a specific range
        [Parameter(Position = 2, Mandatory = $false)]
        [ValidateRange(0, 100)]
        [Int]$Powers = 10
    )

    # Create a structured PSCustomObject for consistent output
    $Object = [PSCustomObject]@{
        Name      = $Name
        Abilities = $Abilities
        Powers    = $Powers
    }

    # Write-Verbose only outputs when -Verbose is specified
    Write-Verbose "Created Superhero with the name: $Name"
    Write-Verbose "$Name was given the following abilities: $Abilities"
    Write-Verbose "$Name has a power of: $Powers"

    return $Object
}

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

Write-Output "=== Creating Superheroes ==="

# Basic usage with mandatory parameter only
Add-Superhero -Name "Basic Hero"

# Full usage with all parameters
Add-Superhero -Name "Comet" -Abilities Flying, LaserEyes -Powers 85

# With verbose output
Add-Superhero -Name "Verbose Hero" -Abilities Flying -Powers 50 -Verbose

# Key Concepts:
# - [CmdletBinding()] enables advanced function features
# - Parameter attributes control behavior (Position, Mandatory)
# - Validation attributes prevent invalid input (ValidateSet, ValidateRange)
# - PSCustomObject provides structured, consistent output
# - Write-Verbose provides optional debugging information
