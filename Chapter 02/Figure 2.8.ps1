# Figure 2.8 - Testing parameter and validation attributes
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates how parameter validation protects your function
# from invalid input. Validation errors are thrown before function code runs.

function Add-Superhero {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Name,

        [Parameter(Position=1)]
        [ValidateSet("Flying", "Indestructable", "LaserEyes")]
        [String[]]$Abilities = "None",

        [Parameter(Position=2, Mandatory=$false)]
        [ValidateRange(0, 100)]
        [Int]$Powers = 10
    )

    $Object = [PSCustomObject]@{
        Abilities = $Abilities
        Name      = $Name
        Powers    = $Powers
    }

    Write-Verbose "Created Superhero with the name: $Name"
    Write-Verbose "$Name was given the following abilities: $Abilities"
    Write-Verbose "$Name has a power of: $Powers"

    return $Object
}

# ============================================================================
# DEMONSTRATION: Valid superhero creation examples
# ============================================================================

# Using named parameters
Add-Superhero -Name "Miss Fury" -Abilities Indestructable -Powers 55

# Using positional parameters (no -Name, -Powers specified)
Add-Superhero "Black Catman" -Powers 15

# Using all positional parameters (Name, Abilities, Powers)
Add-Superhero "Flying Man" Flying 25

# Expected Output: Three valid superhero objects created

# ============================================================================
# DEMONSTRATION: Validation errors (these will fail!)
# ============================================================================

# ERROR 1: Empty string for Name (violates ValidateNotNullOrEmpty)
# Add-Superhero "" Flying 5
# Error: Cannot validate argument on parameter 'Name'. The argument is null or empty.

# ERROR 2: Invalid ability (violates ValidateSet)
# Add-Superhero "Dancer" Dancing 5
# Error: Cannot validate argument on parameter 'Abilities'.
#        The argument "Dancing" does not belong to the set
#        "Flying,Indestructable,LaserEyes"

# ERROR 3: Powers out of range (violates ValidateRange)
# Add-Superhero "Superman" Flying 150
# Error: Cannot validate argument on parameter 'Powers'.
#        The 150 argument is greater than the maximum allowed range of 100.

# Key Concepts:
# - ValidateNotNullOrEmpty: Prevents null or "" values
# - ValidateSet: Restricts input to a predefined list
# - ValidateRange: Ensures numeric values are within bounds
# - Validation runs BEFORE the function body executes
# - Clear error messages help users understand what went wrong
