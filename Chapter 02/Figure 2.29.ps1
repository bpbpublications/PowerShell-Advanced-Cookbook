# Figure 2.29 - PowerShell Classes: Handling null and empty values
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates how PowerShell class constructors handle null
# and empty values, showing the importance of default value handling.

# ============================================================================
# CLASS DEFINITION
# ============================================================================

class NewSuperhero {
    [String] $Name
    [String] $Alignment
    [String[]] $Abilities
    [Int] $Strength
    [Int] $Armor
    [Int] $Luck
    [Int] $Greed
    [Int] $Level

    # Constructor accepts all parameters
    NewSuperhero(
        [String]$Name,
        [String]$Alignment,
        [String[]]$Abilities,
        [Int]$Strength,
        [Int]$Armor,
        [Int]$Luck,
        [Int]$Greed,
        [Int]$Level
    ) {
        $this.Name = $Name
        $this.Alignment = $Alignment
        $this.Abilities = $Abilities
        $this.Strength = $Strength
        $this.Armor = $Armor
        $this.Luck = $Luck
        $this.Greed = $Greed
        $this.Level = $Level
    }
}

# ============================================================================
# CREATING INSTANCE WITH NULL VALUES
# ============================================================================

Write-Output "=== Creating Superhero with Null/Empty Values ==="

# Passing empty string "" and $null for some parameters
# PowerShell converts these to default values for the type:
# - [Int] null → 0
# - [String] null → "" (empty string)
$Comet = [NewSuperhero]::new(
    "Comet",                              # Name (provided)
    "Hero",                               # Alignment (provided)
    @("Flying", "Invulnerability"),       # Abilities (provided)
    75,                                   # Strength (provided)
    80,                                   # Armor (provided)
    "",                                   # Luck - empty string, will error or convert
    $null,                                # Greed - null converts to 0 for [Int]
    $null                                 # Level - null converts to 0 for [Int]
)

$Comet

# Expected Output:
# Name      : Comet
# Alignment : Hero
# Abilities : {Flying, Invulnerability}
# Strength  : 75
# Armor     : 80
# Luck      : 0    <-- Empty string converted to 0
# Greed     : 0    <-- $null converted to 0
# Level     : 0    <-- $null converted to 0

# ============================================================================
# UNDERSTANDING TYPE COERCION
# ============================================================================

Write-Output ""
Write-Output "=== Type Coercion Rules ==="
Write-Output "[Int] with `$null → 0"
Write-Output "[Int] with '' (empty string) → 0"
Write-Output "[String] with `$null → '' (empty string)"
Write-Output "[Bool] with `$null → `$false"

# Key Concepts:
# - PowerShell performs automatic type coercion
# - $null for numeric types ([Int]) becomes 0
# - Empty string "" for numeric types becomes 0
# - This can lead to unexpected values in your objects
# - See Figure 2.30 for handling defaults within the class
# - Consider validation in constructor to catch these issues early
