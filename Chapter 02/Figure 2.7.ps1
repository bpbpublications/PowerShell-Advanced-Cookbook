# Figure 2.7 - Adding abilities and increasing the power of the superhero
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates that PSCustomObject properties can be modified after creation.
# Objects returned from functions remain mutable.

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
# DEMONSTRATION: Modifying object properties after creation
# ============================================================================

# Create a superhero
$Comet = Add-Superhero -Name Comet -Powers 43 -Abilities Flying, LaserEyes -Verbose

# Display initial state
Write-Output "=== Initial State ==="
$Comet

# Expected Output:
# Abilities            Name  Powers
# ---------            ----  ------
# {Flying, LaserEyes}  Comet     43

# Modify the Powers property directly
$Comet.Powers = 50

# Add a new ability to the Abilities array
# Note: += appends to the existing array
$Comet.Abilities += "Indestructable"

# Display modified state
Write-Output ""
Write-Output "=== After Modifications ==="
$Comet

# Expected Output:
# Abilities                            Name  Powers
# ---------                            ----  ------
# {Flying, LaserEyes, Indestructable}  Comet     50

# Key Concepts:
# - PSCustomObject properties are mutable after creation
# - Use dot notation to access and modify properties
# - Arrays can be extended with += operator
# - This allows superhero "leveling up" during gameplay
