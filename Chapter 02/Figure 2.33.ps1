# Figure 2.33 - PowerShell Classes: Adding action methods
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates adding behavior methods to a class that perform
# actions and return values, making objects interactive.

# ============================================================================
# CLASS DEFINITION WITH ACTION METHODS
# ============================================================================

class NewSuperhero {
    # Properties
    [String] $Name
    [String] $Alignment
    [String[]] $Abilities
    [Int] $Strength
    [Int] $Armor
    [Int] $Luck
    [Int] $Greed
    [Int] $Level

    # State tracking property
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

        $this.AddDefaultPropertyValues()
        $this.AdjustBehavior()

        # Initialize flying state
        $this.Flying = $false
    }

    # Initialization methods
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

    [void] AdjustBehavior() {
        switch ($this.Alignment) {
            "Hero"    { $this.Luck += 5; $this.Greed -= 5 }
            "Villain" { $this.Luck -= 5; $this.Greed += 5 }
            Default   { $this.Luck += 3; $this.Greed += 3 }
        }
    }

    # ========================================================================
    # ACTION METHODS: Level Management
    # ========================================================================

    [void] LevelUp() {
        $this.Level++
    }

    [void] LevelDown() {
        $this.Level--
    }

    # ========================================================================
    # ACTION METHODS: Flying State Management
    # ========================================================================

    [void] Fly() {
        # Check if hero has Flying ability
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

    # Method with return value [Bool]
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
# DEMONSTRATION OF ACTION METHODS
# ============================================================================

Write-Output "=== Loading Heroes ==="
$Heroes = Import-SuperheroesFromCsv -InputPath .\HeroMap.csv

Write-Output ""
Write-Output "=== Testing Flying Methods ==="

# Evilin doesn't have Flying ability
$Heroes.Evilin.Fly()
# Output: Superhero Evilin does not have the ability to fly

# Comet has Flying ability
$Heroes.Comet.Fly()
# Output: Superhero Comet starts to fly

Write-Output ""
Write-Output "=== Checking Flying Status ==="
$Heroes.Comet.IsFlying()
# Output: Superhero Comet is flying
# Returns: True

$Heroes.Comet.StopFlying()
# Output: Superhero Comet stops flying

$Heroes.Comet.IsFlying()
# Output: Superhero Comet is not flying
# Returns: False

Write-Output ""
Write-Output "=== Testing Level Methods ==="

# Level up Comet twice
$Heroes.Comet.LevelUp()
Write-Output "Comet Level after LevelUp: $($Heroes.Comet.Level)"
# Output: 2

$Heroes.Comet.LevelUp()
Write-Output "Comet Level after second LevelUp: $($Heroes.Comet.Level)"
# Output: 3

$Heroes.Comet.LevelDown()
Write-Output "Comet Level after LevelDown: $($Heroes.Comet.Level)"
# Output: 2

# Key Concepts:
# - [void] methods perform actions without returning values
# - [Bool] methods return true/false and can perform actions
# - Methods can modify object state ($this.Flying = $true)
# - Methods can check conditions before performing actions
# - "in" operator checks if value exists in array: "Flying" -in $this.Abilities
# - Write-Host outputs to console (not to pipeline like Write-Output)
# - This OOP pattern encapsulates behavior with data
