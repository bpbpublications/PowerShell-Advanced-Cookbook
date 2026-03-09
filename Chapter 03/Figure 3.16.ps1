# Figure 3.16 - Script blocks as callbacks for dynamic behavior
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates using script blocks as callbacks - passing
# executable code as a parameter to functions. This enables flexible,
# reusable functions that can perform different actions based on the
# callback provided.

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

$Superheroes = Wrapper-CsvImport -InputPath .\HeroMap2.csv

# ============================================================================
# CALLBACK PATTERN: FUNCTION THAT ACCEPTS A SCRIPT BLOCK
# ============================================================================

function Invoke-Ability {
    param (
        # [scriptblock] type ensures only executable code blocks are accepted
        [scriptblock]$Callback
    )

    # The call operator (&) executes the script block
    # We pass a specific superhero as an argument to the callback
    & $Callback $Superheroes."Atmos Fear"
}

# ============================================================================
# DEFINING CALLBACK SCRIPT BLOCKS
# ============================================================================

# First callback: Uses the superhero's first ability
$MyCallback = {
    param($Superhero)
    Write-Output "$($Superhero.Name) using ability $($Superhero.Abilities[0])"
}

# Second callback: Uses the superhero's second ability
$MyCallback2 = {
    param($Superhero)
    Write-Output "$($Superhero.Name) using ability $($Superhero.Abilities[1])"
}

# ============================================================================
# EXECUTING WITH DIFFERENT CALLBACKS
# ============================================================================

# Same function, different behavior based on callback
Invoke-Ability -Callback $MyCallback
Invoke-Ability -Callback $MyCallback2

# ============================================================================
# KEY CONCEPTS DEMONSTRATED
# ============================================================================
# - Script blocks are defined with { } braces
# - The [scriptblock] type constrains the parameter
# - The call operator (&) executes script blocks
# - Script blocks can accept parameters via param()
# - Callbacks enable "plug-in" behavior patterns
# - The same function produces different output based on the callback

# Expected Output:
# Atmos Fear using ability Telepathy
# Atmos Fear using ability Super Strength

# ============================================================================
# ALTERNATIVE CALLBACK PATTERNS
# ============================================================================

# You can also define callbacks inline:
# Invoke-Ability -Callback { param($s) Write-Output "Inline: $($s.Name)" }

# Or use automatic variable $args instead of param():
# $CallbackWithArgs = { Write-Output "Hero: $($args[0].Name)" }
