# Figure 3.9 - Complex labeled loops with mission game simulation
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates advanced labeled loop control in a practical
# game simulation scenario. Multiple labeled loops work together with
# break and continue to control complex flow between missions, heroes,
# and villains.

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

    # Constructor initializes superhero with provided values
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

    # Set default values for properties that are 0 or empty
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

    # Adjust luck and greed based on alignment
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
# CSV IMPORT WRAPPER FUNCTION
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
# MISSION GAME SIMULATION WITH LABELED LOOPS
# ============================================================================

# Load superheroes from CSV
$Superheroes = Wrapper-CsvImport -InputPath .\HeroMap.csv

# Define multiple missions to complete
$Missions = @("Prevent Nuclear Meltdown", "Defend the City", "Stop Biological Outbreak")

# OUTER LOOP: Iterate through each mission
# The :MissionLoop label allows us to skip to the next mission when one completes
:MissionLoop foreach ($Mission in $Missions) {
    Write-Output "`r`nMission: $Mission`r`n"

    # Build lists of available heroes and villains for this mission
    $Heroes = New-Object System.Collections.ArrayList
    $Superheroes.Values | Where-Object { $_.Alignment -eq "Hero" } |
        ForEach-Object { $Heroes += $_.Name }

    $Villains = New-Object System.Collections.ArrayList
    $Superheroes.Values | Where-Object { $_.Alignment -eq "Villain" } |
        ForEach-Object { $Villains += $_.Name }

    # HERO LOOP: Continue while heroes remain
    :HeroLoop for ($i = 0; $i -lt $Heroes.Count) {

        # VILLAIN LOOP: Continue while villains remain
        :VillainLoop for ($j = 0; $j -lt $Villains.Count) {

            # Randomly select combatants for this battle
            $Hero = $Heroes[(Get-Random -Minimum 0 -Maximum $Heroes.Count)]
            $Villain = $Villains[(Get-Random -Minimum 0 -Maximum $Villains.Count)]

            # Calculate combat scores with random element
            $ChosenHeroStrength = ($Superheroes.$Hero.Strength) +
                (Get-Random -Minimum 1 -Maximum 50) +
                ($Superheroes.$Hero.Luck)

            $ChosenVillainArmor = ($Superheroes.$Villain.Armor) +
                (Get-Random -Minimum 1 -Maximum 50) +
                ($Superheroes.$Villain.Greed)

            # Hero Wins the battle
            if ($ChosenHeroStrength -ge $ChosenVillainArmor) {
                Write-Output "Hero $Hero ($ChosenHeroStrength) defeats $Villain ($ChosenVillainArmor)"
                $Villains.Remove($Villain)

                # All villains defeated = Mission Success
                if ($Villains.Count -eq 0) {
                    Write-Output "`r`nMission Successful: $Mission"
                    continue MissionLoop  # Skip to next mission
                }
                else {
                    continue HeroLoop  # Hero continues fighting
                }
            }
            # Villain Wins the battle
            else {
                Write-Output "Villain $Villain ($ChosenVillainArmor) defeats $Hero ($ChosenHeroStrength)"
                $Heroes.Remove($Hero)

                # All heroes defeated = Mission Failed
                if ($Heroes.Count -eq 0) {
                    Write-Output "`r`nMission Failed: $Mission"
                    break HeroLoop  # Exit hero loop, move to next mission
                }
                else {
                    break VillainLoop  # Hero lost, try with next hero
                }
            }
        }
    }
}

# ============================================================================
# KEY CONCEPTS DEMONSTRATED
# ============================================================================
# - Three levels of nested labeled loops: MissionLoop, HeroLoop, VillainLoop
# - 'continue MissionLoop' skips remaining battles, advances to next mission
# - 'continue HeroLoop' - hero won, continues to fight more villains
# - 'break HeroLoop' - all heroes defeated, mission fails
# - 'break VillainLoop' - hero lost, next hero takes over
# - ArrayList.Remove() dynamically shrinks the collection during iteration
# - Random combat adds unpredictability to the simulation
