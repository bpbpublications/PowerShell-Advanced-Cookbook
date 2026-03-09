# Figure 2.6 - Invoking the Add-Superhero function with verbose output
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates an advanced function with CmdletBinding, parameter attributes,
# validation, and verbose output. This is the foundation for professional functions.

function Add-Superhero {
    # CmdletBinding makes this an "advanced function"
    # It enables common parameters like -Verbose, -Debug, -ErrorAction, etc.
    [CmdletBinding()]
    param (
        # Position=0: First positional argument becomes $Name
        # Mandatory=$true: Function will prompt if not provided
        [Parameter(Position=0, Mandatory=$true)]
        # Validates that Name is not null or empty string
        [ValidateNotNullOrEmpty()]
        [String]$Name,

        # Position=1: Second positional argument becomes $Abilities
        # Default value "None" used if not specified
        [Parameter(Position=1)]
        # Only these three abilities are valid - anything else throws an error
        [ValidateSet("Flying", "Indestructable", "LaserEyes")]
        [String[]]$Abilities = "None",

        # Position=2: Third positional argument becomes $Powers
        # Mandatory=$false is the default, shown here for clarity
        [Parameter(Position=2, Mandatory=$false)]
        # Powers must be between 0 and 100
        [ValidateRange(0, 100)]
        [Int]$Powers = 10
    )

    # Create a custom object to hold the superhero data
    # PSCustomObject provides structured, ordered output
    $Object = [PSCustomObject]@{
        Abilities = $Abilities
        Name      = $Name
        Powers    = $Powers
    }

    # Write-Verbose only outputs when -Verbose switch is used
    # This is enabled by CmdletBinding
    Write-Verbose "Created Superhero with the name: $Name"
    Write-Verbose "$Name was given the following abilities: $Abilities"
    Write-Verbose "$Name has a power of: $Powers"

    return $Object
}

# ============================================================================
# DEMONSTRATION: Creating a superhero with verbose output
# ============================================================================

# Create Comet with multiple abilities and capture in variable
# The -Verbose switch enables the Write-Verbose output
$Comet = Add-Superhero -Name Comet -Powers 43 -Abilities Flying, LaserEyes -Verbose

# Expected Verbose Output:
# VERBOSE: Created Superhero with the name: Comet
# VERBOSE: Comet was given the following abilities: Flying LaserEyes
# VERBOSE: Comet has a power of: 43

# Display the created object
$Comet

# Expected Output:
# Abilities     Name  Powers
# ---------     ----  ------
# {Flying, LaserEyes} Comet     43

# Access individual properties using dot notation
$Comet.Name         # Returns: Comet
$Comet.Abilities    # Returns: Flying, LaserEyes
$Comet.Powers       # Returns: 43
