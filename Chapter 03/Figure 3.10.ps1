# Figure 3.10 - While and Do-While loops with monster battle simulation
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates while and do-while loops combined with labeled
# breaks and continues in a hero vs monster battle simulation. Shows how
# different loop types can be nested and controlled with labels.

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
# BATTLE SETUP
# ============================================================================

$Superheroes = Wrapper-CsvImport -InputPath .\HeroMap.csv

# Create a powerful monster using the class with null alignment
$Monster = [NewSuperhero]::new("Monster", $null, @(), 52, 63, 0, 0, 25)
# Add-Member dynamically adds HitPoints property not in the class
$Monster | Add-Member -NotePropertyName HitPoints -NotePropertyValue 1000

# Select a hero for the battle
$Hero = $Superheroes."Alias X"
$Hero | Add-Member -NotePropertyName HitPoints -NotePropertyValue 780

# Dice roll function for combat randomness
function RollDice {
    return Get-Random -Minimum 50 -Maximum 100
}

# ============================================================================
# MONSTER BATTLE WITH NESTED WHILE/DO-WHILE LOOPS
# ============================================================================

$Defeated = $false

# OUTER: While loop - continues until someone is defeated
:Outer while (-not $Defeated) {

    # CENTER: Do-While loop - hero attacks until monster HP reaches 0
    :Center do {
        Write-Output "$($Hero.Name) is attacking the monster"
        $Roll = RollDice

        # INNER: While loop - hero must roll higher than monster's armor
        :Inner while ($Roll -lt $Monster.Armor) {
            Write-Output "Hero misses ($Roll vs. $($Monster.Armor))"
            Write-Output "Monster retaliates"

            $MonsterRoll = RollDice
            if ($MonsterRoll -gt $Hero.Armor) {
                $Hero.HitPoints -= $MonsterRoll
                Write-Host "Monster hits hero with $MonsterRoll (Left: $($Hero.HitPoints))"

                # Hero defeated - break out of entire battle
                if ($Hero.HitPoints -le 0) {
                    Write-Output "Hero is defeated"
                    break Outer  # Exit all loops - battle over
                }
                else {
                    continue Center  # Hero survives, try attacking again
                }
            }
            else {
                Write-Output "Monster misses"
                continue Center  # Monster missed, hero attacks again
            }
        }

        # Hero's attack lands - calculate damage
        $Hit = ($Hero.Strength) + ($Roll)
        $Monster.HitPoints -= $Hit
        Write-Output "Hero hit monster with $Hit (Left: $($Monster.HitPoints))"

    } while ($Monster.HitPoints -gt 0)

    # Monster defeated
    Write-Output "Monster is defeated"
    $Defeated = $true
}

# ============================================================================
# KEY CONCEPTS DEMONSTRATED
# ============================================================================
# - Three different loop types nested: while, do-while, while
# - 'while' checks condition BEFORE first iteration
# - 'do-while' executes at least once, checks condition AFTER
# - 'break Outer' exits all three loops immediately (hero dies)
# - 'continue Center' restarts the do-while (hero attacks again)
# - Add-Member dynamically adds properties to existing objects
# - Labeled loops enable precise control in complex battle logic
