# Recipe: Create Advanced Conditional Statements Using Comparison Operators
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates using PowerShell's comparison and logical operators
# to create sophisticated conditional evaluations for complex decision-making.

# ============================================================================
# SUPERHERO CLASS DEFINITION
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
    [bool] $Flying

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

        $this.AddDefaultPropertyValues()
        $this.AdjustBehavior()
        $this.Flying = $false
    }

    [void] AddDefaultPropertyValues() {
        switch ($null) {
            { $this.Strength -eq 0 } { $this.Strength = 10 }
            { $this.Armor -eq 0 } { $this.Armor = 10 }
            { $this.Luck -eq 0 } { $this.Luck = 5 }
            { $this.Greed -eq 0 } { $this.Greed = 5 }
            { $this.Level -eq 0 } { $this.Level = 1 }
            { $this.Alignment -eq "" } { $this.Alignment = "Neutral" }
        }
    }

    [void] AdjustBehavior() {
        switch ($this.Alignment) {
            "Hero" {
                $this.Luck += 5
                $this.Greed -= 5
            }
            "Villain" {
                $this.Luck -= 5
                $this.Greed += 5
            }
            Default {
                $this.Luck += 3
                $this.Greed += 3
            }
        }
    }

    [void] LevelUp() { $this.Level++ }
    [void] LevelDown() { $this.Level-- }

    [void] Fly() {
        if ("Flying" -in $this.Abilities) {
            if ($this.Flying) {
                Write-Host "Superhero $($this.Name) is already flying"
            }
            else {
                Write-Host "Superhero $($this.Name) starts to fly"
                $this.Flying = $true
            }
        }
        else {
            Write-Host "Superhero $($this.Name) does not have the ability to fly"
        }
    }

    [Bool] IsFlying() {
        if ("Flying" -in $this.Abilities) {
            if ($this.Flying) {
                Write-Host "Superhero $($this.Name) is flying"
            }
            else {
                Write-Host "Superhero $($this.Name) is not flying"
            }
        }
        else {
            Write-Host "Superhero $($this.Name) does not have the ability to fly"
        }
        return $this.Flying
    }

    [void] StopFlying() {
        if ("Flying" -in $this.Abilities) {
            if ($this.Flying) {
                Write-Host "Superhero $($this.Name) stops flying"
                $this.Flying = $false
            }
            else {
                Write-Host "Superhero $($this.Name) is not flying"
            }
        }
        else {
            Write-Host "Superhero $($this.Name) does not have the ability to fly"
        }
    }
}

# ============================================================================
# CSV IMPORT WRAPPER
# ============================================================================

function Wrapper-CsvImport {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [String]$InputPath,
        [String]$Delimiter = ";"
    )

    $Superheroes = @{}
    $CsvFile = Import-Csv -Path $InputPath -Delimiter $Delimiter

    foreach ($Item in $CsvFile) {
        $Superheroes[$Item.Name] = [NewSuperhero]::new(
            $Item.Name,
            $Item.Alignment,
            $Item.Abilities -split ",",
            $Item.Strength,
            $Item.Armor,
            $Item.Luck,
            $Item.Greed,
            $Item.Level
        )
    }

    return $Superheroes
}

# ============================================================================
# SAMPLE DATA FOR DEMONSTRATIONS
# ============================================================================

# Sample hero and villain data for demonstration
# Name      : Tornado Tim
# Alignment : Hero
# Abilities : {Pyrokinesis, Mind Control}
# Strength  : 59
# Armor     : 54
# Luck      : 27
# Greed     : 21
# Level     : 1

# Name      : Chiss
# Alignment : Villain
# Abilities : {Telepathy, Invulnerability}
# Strength  : 45
# Armor     : 70
# Luck      : 5
# Greed     : 26
# Level     : 1

$Superheroes = Wrapper-CsvImport -InputPath .\HeroMap.csv

$Hero = $Superheroes."Tornado Tim"
$Villain = $Superheroes."Chiss"

# ============================================================================
# COMPARISON OPERATORS OVERVIEW
# ============================================================================

# PowerShell comparison operators:
# -eq    Equal to
# -ne    Not equal to
# -gt    Greater than
# -ge    Greater than or equal to
# -lt    Less than
# -le    Less than or equal to
# -like  Wildcard pattern matching
# -match Regular expression matching
# -in    Value is in collection
# -notin Value is not in collection
# -contains Collection contains value
# -notcontains Collection does not contain value

# ============================================================================
# COMPLEX CONDITIONAL EXAMPLE: COMBAT EVALUATION
# ============================================================================

# Generate random dice rolls for combat
$HeroDiceRoll = Get-Random -Minimum 1 -Maximum 50
$VillainDiceRoll = Get-Random -Minimum 1 -Maximum 50

# COMPLEX CONDITION: Hero wins if ALL three conditions are true:
# 1. Hero's strength + luck exceeds villain's armor
# 2. Hero's greed + roll is LESS than villain's (hero stays focused)
# 3. Hero's luck + roll is GREATER than villain's (fortune favors hero)

# Use parentheses to group conditions for clarity and correctness
$HeroWins = (
    ($Hero.Strength + $Hero.Luck) -gt $Villain.Armor
) -and (
    ($Hero.Greed + $HeroDiceRoll) -lt ($Villain.Greed + $VillainDiceRoll)
) -and (
    ($Hero.Luck + $HeroDiceRoll) -gt ($Villain.Luck + $VillainDiceRoll)
)

# Display the result
$HeroWins

# ============================================================================
# HELPER FUNCTION: AGE CLASSIFICATION WITH MULTIPLE CONDITIONS
# ============================================================================

function WhatAmI ([int]$Age) {
    # Using elseif chains for mutually exclusive conditions
    if ($Age -lt 13) {
        Write-Output "You are a child"
    }
    elseif ($Age -ge 13 -and $Age -lt 20) {
        # Compound condition: between 13 and 19
        Write-Output "You are a teenager"
    }
    elseif ($Age -ge 20) {
        Write-Output "You are an adult"
    }
}

# ============================================================================
# STATISTICAL SIMULATION: CALCULATING HIT PROBABILITY
# ============================================================================

# Simulate many battles to calculate the hero's hit probability
$NumberOfSimulations = 0
$HeroHits = 0

while ($NumberOfSimulations -lt 10000) {
    $HeroDiceRoll = Get-Random -Minimum 1 -Maximum 50
    $VillainDiceRoll = Get-Random -Minimum 1 -Maximum 50

    # Same complex condition as above, evaluated 10,000 times
    if ((
        ($Hero.Strength + $Hero.Luck) -gt $Villain.Armor
    ) -and (
        ($Hero.Greed + $HeroDiceRoll) -lt ($Villain.Greed + $VillainDiceRoll)
    ) -and (
        ($Hero.Luck + $HeroDiceRoll) -gt ($Villain.Luck + $VillainDiceRoll)
    )) {
        $HeroHits++
    }
    $NumberOfSimulations++
}

# Calculate and display hit percentage
[int]$ChanceOfHeroHit = ($HeroHits / $NumberOfSimulations) * 100
Write-Output "The chance of the hero successfully landing a hit is: $ChanceOfHeroHit %"

# ============================================================================
# COLLECTION MEMBERSHIP OPERATORS: -in, -notin, -contains
# ============================================================================

$VillainArray = "Chiss", "Manx", "Torque"
$HeroArray = "Tornado Tim", "Destiny", "Alias X"

# Check if value is IN a collection (value on LEFT)
# Returns $true because Chiss is a villain, not a hero
$IsVillainNotHero = ("Chiss" -notin $HeroArray -and "Chiss" -in $VillainArray)
$IsVillainNotHero  # True

# ============================================================================
# TYPE CHECKING WITH COMPARISON OPERATORS
# ============================================================================

# Check the base type of the array
# .GetType().BaseType.Name returns the base class name
$IsArray = ($HeroArray.GetType().BaseType.Name -eq "Array")
$IsArray  # True

# ============================================================================
# KEY CONCEPTS SUMMARY
# ============================================================================

# 1. GROUPING: Always use parentheses for complex conditions
#    - Improves readability
#    - Ensures correct operator precedence
#    - Makes debugging easier

# 2. LOGICAL OPERATORS:
#    - -and: Both conditions must be true
#    - -or: At least one condition must be true
#    - -not or !: Inverts the condition

# 3. COLLECTION OPERATORS:
#    - -in/-notin: Value on left, collection on right
#    - -contains/-notcontains: Collection on left, value on right

# 4. BEST PRACTICES:
#    - Break complex conditions across multiple lines
#    - Use meaningful variable names for sub-conditions
#    - Comment the purpose of complex evaluations
#    - Consider extracting to functions for reusability

# Expected Output:
# False (or True, depending on random rolls)
# The chance of the hero successfully landing a hit is: 12 %
# True
# True
