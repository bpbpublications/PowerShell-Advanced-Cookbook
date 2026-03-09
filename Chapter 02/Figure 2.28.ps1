# Figure 2.28 - PowerShell Classes: Basic definition and constructor
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates defining a PowerShell class with typed properties
# and a constructor for creating instances.

# ============================================================================
# CLASS DEFINITION
# ============================================================================

class NewSuperhero {
    # Property declarations with explicit types
    # These define the structure of the object
    [String] $Name
    [String] $Alignment
    [String[]] $Abilities    # Array of strings
    [Int] $Strength
    [Int] $Armor
    [Int] $Luck
    [Int] $Greed
    [Int] $Level

    # ========================================================================
    # CONSTRUCTOR
    # ========================================================================
    # The constructor has the same name as the class
    # It's called when you use ::new() or New-Object

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
        # $this refers to the current instance being created
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
# CREATING INSTANCES
# ============================================================================

Write-Output "=== Creating Superhero Instances ==="

# Method 1: Using ::new() static method (preferred)
$Comet = [NewSuperhero]::new(
    "Comet",                              # Name
    "Hero",                               # Alignment
    @("Flying", "Invulnerability"),       # Abilities (array)
    75,                                   # Strength
    80,                                   # Armor
    15,                                   # Luck
    5,                                    # Greed
    1                                     # Level
)

# Method 2: Using New-Object cmdlet (older syntax)
$Evilin = New-Object NewSuperhero -ArgumentList @(
    "Evilin",
    "Villain",
    @("Flying", "Invulnerability"),
    60, 45, 2, 20, 1
)

# ============================================================================
# VIEW INSTANCES
# ============================================================================

Write-Output ""
Write-Output "=== Comet (Hero) ==="
$Comet

# Expected Output:
# Name      : Comet
# Alignment : Hero
# Abilities : {Flying, Invulnerability}
# Strength  : 75
# Armor     : 80
# Luck      : 15
# Greed     : 5
# Level     : 1

Write-Output ""
Write-Output "=== Evilin (Villain) ==="
$Evilin

# Expected Output:
# Name      : Evilin
# Alignment : Villain
# Abilities : {Flying, Invulnerability}
# Strength  : 60
# Armor     : 45
# Luck      : 2
# Greed     : 20
# Level     : 1

# Key Concepts:
# - Classes define a blueprint/template for objects
# - Properties are typed ([String], [Int], [String[]])
# - Constructor initializes the object when created
# - $this refers to the current instance within class methods
# - Two ways to instantiate: [ClassName]::new() or New-Object
# - Classes enforce type safety - pass wrong type and you get an error
