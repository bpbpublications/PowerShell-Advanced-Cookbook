# Figure 3.15 - Nested switch statements for complex decision trees
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates nested switch statements to handle complex
# decision logic based on multiple criteria. Here we apply bonuses
# based on both superhero level AND alignment.

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

    # Note: Uses "Superhero" instead of "Hero" in this variant
    [void] AdjustBehavior() {
        switch ($this.Alignment) {
            "Superhero" {
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
# LOAD SUPERHEROES
# ============================================================================

# Using HeroMap2.csv which has different level distributions
$Superheroes = Wrapper-CsvImport -InputPath .\HeroMap2.csv

# ============================================================================
# NESTED SWITCH STATEMENTS FOR BONUS CALCULATION
# ============================================================================

foreach ($Superhero in $Superheroes.Values) {
    Write-Output "`r`nProcessing $($Superhero.Name) ($($Superhero.Alignment)):"

    # Random dice roll affects bonus multiplier
    $DiceRoll = Get-Random -Minimum 1 -Maximum 4

    # OUTER SWITCH: Evaluate level range using script block conditions
    # $_ represents the switch input ($Superhero.Level)
    switch ($Superhero.Level) {

        # Level 1-9: Low-level superhero
        { $_ -lt 10 } {
            Write-Output "Low-level superhero"

            # INNER SWITCH: Different bonuses based on alignment
            switch ($Superhero.Alignment) {
                "Hero" {
                    $ExtraLuck = 2 * $DiceRoll
                    Write-Output "Gains extra luck: $ExtraLuck"
                    $Superhero.Luck += $ExtraLuck
                }
                "Villain" {
                    $ExtraGreed = 2 * $DiceRoll
                    Write-Output "Gains extra greed: $ExtraGreed"
                    $Superhero.Greed += $ExtraGreed
                }
                Default {
                    # Neutral characters get both, but less
                    $ExtraLuck = 1 * $DiceRoll
                    $ExtraGreed = 1 * $DiceRoll
                    Write-Output "Gains extra luck: $ExtraLuck"
                    Write-Output "Gains extra greed: $ExtraGreed"
                    $Superhero.Luck += $ExtraLuck
                    $Superhero.Greed += $ExtraGreed
                }
            }
        }

        # Level 10-24: Medium-level superhero
        { $_ -ge 10 -and $_ -lt 25 } {
            Write-Output "Medium-level superhero"

            switch ($Superhero.Alignment) {
                "Hero" {
                    $ExtraLuck = 3 * $DiceRoll
                    Write-Output "Gains extra luck: $ExtraLuck"
                    $Superhero.Luck += $ExtraLuck
                }
                "Villain" {
                    $ExtraGreed = 3 * $DiceRoll
                    Write-Output "Gains extra greed: $ExtraGreed"
                    $Superhero.Greed += $ExtraGreed
                }
                Default {
                    $ExtraLuck = 2 * $DiceRoll
                    $ExtraGreed = 2 * $DiceRoll
                    Write-Output "Gains extra luck: $ExtraLuck"
                    Write-Output "Gains extra greed: $ExtraGreed"
                    $Superhero.Luck += $ExtraLuck
                    $Superhero.Greed += $ExtraGreed
                }
            }
        }

        # Level 25-49: High-level superhero
        { $_ -ge 25 -and $_ -lt 50 } {
            Write-Output "High-level superhero"

            switch ($Superhero.Alignment) {
                "Hero" {
                    $ExtraLuck = 4 * $DiceRoll
                    Write-Output "Gains extra luck: $ExtraLuck"
                    $Superhero.Luck += $ExtraLuck
                }
                "Villain" {
                    $ExtraGreed = 4 * $DiceRoll
                    Write-Output "Gains extra greed: $ExtraGreed"
                    $Superhero.Greed += $ExtraGreed
                }
                Default {
                    $ExtraLuck = 3 * $DiceRoll
                    $ExtraGreed = 3 * $DiceRoll
                    Write-Output "Gains extra luck: $ExtraLuck"
                    Write-Output "Gains extra greed: $ExtraGreed"
                    $Superhero.Luck += $ExtraLuck
                    $Superhero.Greed += $ExtraGreed
                }
            }
        }

        # Level 50+: Max-level superhero
        Default {
            Write-Output "Max-level superhero"
            switch ($Superhero.Alignment) {
                Default {
                    # Too powerful - no additional bonuses
                    Write-Output "Too high powered. No new benefits."
                }
            }
        }
    }
}

Write-Output "Processed all superheroes"

# ============================================================================
# KEY CONCEPTS DEMONSTRATED
# ============================================================================
# - Outer switch uses script block conditions: { $_ -lt 10 }
# - $_ represents the value being switched on ($Superhero.Level)
# - Inner switch uses simple string matching for Alignment
# - Default case handles unmatched values in both switches
# - Multiple conditions can be combined: { $_ -ge 10 -and $_ -lt 25 }
# - Nested switches create a decision matrix: Level x Alignment
# - Each combination (Low-Hero, Medium-Villain, etc.) has unique logic

# Expected Output (example):
# Processing Tornado Tim (Hero):
# Medium-level superhero
# Gains extra luck: 9
#
# Processing Chiss (Villain):
# High-level superhero
# Gains extra greed: 12
