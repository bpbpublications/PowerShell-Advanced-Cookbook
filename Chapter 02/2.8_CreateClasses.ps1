# Recipe 2.8: Creating PowerShell Classes
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates creating a complete PowerShell class with
# properties, constructor, and action methods.

# ============================================================================
# CLASS DEFINITION
# ============================================================================

class NewSuperhero {
    # Property declarations with types
    [String] $Name
    [String] $Alignment
    [String[]] $Abilities
    [Int] $Strength
    [Int] $Armor
    [Int] $Luck
    [Int] $Greed
    [Int] $Level

    # State tracking
    [bool] $Flying

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

        # Initialize state and apply modifiers
        $this.AddDefaultPropertyValues()
        $this.AdjustBehavior()
        $this.Flying = $false
    }

    # Set default values for missing/zero properties
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

    # Apply alignment-based stat modifiers
    [void] AdjustBehavior() {
        switch ($this.Alignment) {
            "Hero"    { $this.Luck += 5; $this.Greed -= 5 }
            "Villain" { $this.Luck -= 5; $this.Greed += 5 }
            Default   { $this.Luck += 3; $this.Greed += 3 }
        }
    }

    # Level management methods
    [void] LevelUp() {
        $this.Level++
    }

    [void] LevelDown() {
        $this.Level--
    }

    # Flying state methods
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
# WRAPPER FUNCTION FOR CSV IMPORT
# ============================================================================

function Import-SuperheroesFromCsv {
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
            ($Item.Abilities -split ","),
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
# USAGE EXAMPLES
# ============================================================================

Write-Output "=== Creating Superhero via Class ==="
$Comet = [NewSuperhero]::new("Comet", "Hero", @("Flying", "Invulnerability"), 75, 80, 15, 5, 1)
$Comet

Write-Output ""
Write-Output "=== Testing Methods ==="
$Comet.Fly()
$Comet.IsFlying()
$Comet.LevelUp()
Write-Output "Level after LevelUp: $($Comet.Level)"

# Key Concepts:
# - Classes define typed properties and methods
# - Constructor initializes object state
# - $this refers to the current instance
# - [void] methods don't return values
# - Methods can modify object state and check conditions
