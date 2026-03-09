# Figure 2.31 - PowerShell Classes: Adding behavior adjustment methods
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates adding multiple methods to a class that work together
# to configure the object based on its alignment.

# ============================================================================
# CLASS DEFINITION WITH MULTIPLE METHODS
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

        # Call initialization methods in sequence
        $this.AddDefaultPropertyValues()
        $this.AdjustBehavior()
    }

    # Apply default values for missing/zero properties
    [void] AddDefaultPropertyValues() {
        switch ($null) {
            { $this.Strength -eq 0 }   { $this.Strength = 10 }
            { $this.Armor -eq 0 }      { $this.Armor = 10 }
            { $this.Luck -eq 0 }       { $this.Luck = 5 }
            { $this.Greed -eq 0 }      { $this.Greed = 5 }
            { $this.Level -eq 0 }      { $this.Level = 1 }
            { $this.Alignment -eq "" } { $this.Alignment = "Neutral" }
        }
    }

    # ========================================================================
    # METHOD: Adjust Stats Based on Alignment
    # ========================================================================
    # Heroes get luck bonus, Villains get greed bonus, Neutrals get both

    [void] AdjustBehavior() {
        switch ($this.Alignment) {
            "Hero" {
                $this.Luck += 5     # Heroes are lucky
                $this.Greed -= 5    # Heroes are selfless
            }
            "Villain" {
                $this.Luck -= 5     # Villains have bad karma
                $this.Greed += 5    # Villains are greedy
            }
            Default {
                $this.Luck += 3     # Neutrals get modest bonuses
                $this.Greed += 3
            }
        }
    }
}

# ============================================================================
# CREATING INSTANCE WITH BEHAVIOR ADJUSTMENT
# ============================================================================

Write-Output "=== Creating Superhero (Alignment affects stats) ==="

# Create with null alignment - will default to "Neutral"
# which then triggers the Default case in AdjustBehavior
$Comet = [NewSuperhero]::new(
    "Comet",
    $null,                                # Alignment → "Neutral" (default)
    @("Flying", "Invulnerability"),
    75, 80,
    "",                                   # Luck → 5 (default) + 3 (neutral bonus) = 8
    $null,                                # Greed → 5 (default) + 3 (neutral bonus) = 8
    $null                                 # Level → 1 (default)
)

$Comet

# Expected Output:
# Name      : Comet
# Alignment : Neutral    <-- Default applied
# Abilities : {Flying, Invulnerability}
# Strength  : 75
# Armor     : 80
# Luck      : 8          <-- 5 (default) + 3 (neutral bonus)
# Greed     : 8          <-- 5 (default) + 3 (neutral bonus)
# Level     : 1

# Key Concepts:
# - Methods can call other methods using $this.MethodName()
# - Constructor can chain multiple initialization methods
# - Order of method calls matters - defaults must be set before adjustments
# - switch statement works well for multi-case behavior logic
# - Encapsulating logic in methods makes code reusable and testable
