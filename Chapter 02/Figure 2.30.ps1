# Figure 2.30 - PowerShell Classes: Adding methods for default values
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates adding methods to a class that can set default
# values for properties that weren't provided or were set to zero.

# ============================================================================
# CLASS DEFINITION WITH DEFAULT VALUE METHOD
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

    # Constructor
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

        # Call the default values method after setting properties
        $this.AddDefaultPropertyValues()
    }

    # ========================================================================
    # METHOD: Apply Default Values
    # ========================================================================
    # [void] indicates this method returns nothing
    # The switch statement with $null is a pattern for checking multiple conditions

    [void] AddDefaultPropertyValues() {
        # Using switch with $null as a selector allows multiple condition checks
        # Each condition is evaluated, and matching cases execute
        switch ($null) {
            { $this.Strength -eq 0 }   { $this.Strength = 10 }
            { $this.Armor -eq 0 }      { $this.Armor = 10 }
            { $this.Luck -eq 0 }       { $this.Luck = 5 }
            { $this.Greed -eq 0 }      { $this.Greed = 5 }
            { $this.Level -eq 0 }      { $this.Level = 1 }
            { $this.Alignment -eq "" } { $this.Alignment = "Neutral" }
        }
    }
}

# ============================================================================
# CREATING INSTANCE WITH MISSING VALUES
# ============================================================================

Write-Output "=== Creating Superhero with Defaults Applied ==="

# Pass empty/null values - the AddDefaultPropertyValues method will fix them
$Comet = [NewSuperhero]::new(
    "Comet",                              # Name (provided)
    "Hero",                               # Alignment (provided)
    @("Flying", "Invulnerability"),       # Abilities (provided)
    75,                                   # Strength (provided)
    80,                                   # Armor (provided)
    "",                                   # Luck → will become 5 (default)
    $null,                                # Greed → will become 5 (default)
    $null                                 # Level → will become 1 (default)
)

$Comet

# Expected Output:
# Name      : Comet
# Alignment : Hero
# Abilities : {Flying, Invulnerability}
# Strength  : 75
# Armor     : 80
# Luck      : 5    <-- Default applied (was 0)
# Greed     : 5    <-- Default applied (was 0)
# Level     : 1    <-- Default applied (was 0)

# Key Concepts:
# - [void] methods don't return values - they just perform actions
# - Methods are called using $this.MethodName() within the class
# - The switch($null) pattern allows checking multiple conditions
# - Constructor can call methods to initialize object state
# - Default values ensure objects are always in a valid state
# - This pattern prevents null/zero values from causing issues later
