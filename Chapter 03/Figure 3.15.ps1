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
            { $this.Strength -eq 0} { $this.Strength = 10 }
            { $this.Armor -eq 0} { $this.Armor = 10 }
            { $this.Luck -eq 0} { $this.Luck = 5 }
            { $this.Greed -eq 0} { $this.Greed = 5 }
            { $this.Level -eq 0} { $this.Level = 1}
            { $this.Alignment -eq ""} { $this.Alignment = "Neutral"}
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

    [void] LevelUp() {
        $this.Level ++
    }

    [void] LevelDown() {
        $this.Level --
    }

    [void] Fly() {
        if ("Flying" -in $this.Abilities){
            if ($this.Flying){
                Write-Host "Superhero $($this.name) is already flying"
            }
            else{
                Write-Host "Superhero $($this.name) starts to fly"
                $this.Flying = $true
            }
        }
        else{
            Write-Host "Superhero $($this.Name) does not have the ability to fly"
        }
    }

    [Bool] IsFlying() {
        if ("Flying" -in $this.Abilities){
            if ($this.Flying){
                Write-Host "Superhero $($this.name) is flying"
                
            }
            else{
                Write-Host "Superhero $($this.name) is not flying"
                
            }
            
        }
        else{
            Write-Host "Superhero $($this.Name) does not have the ability to fly"
            
        }
        return $this.Flying
    }

    [void] StopFlying() {
        if ("Flying" -in $this.Abilities){
            if ($this.Flying){
                Write-Host "Superhero $($this.name) stops flying"
                $this.Flying = $false
            }
            else{
                Write-Host "Superhero $($this.name) is not flying"
                
            }
        }
        else{
            Write-Host "Superhero $($this.Name) does not have the ability to fly"
        }
    }
}

function Wrapper-CsvImport {
    [CmdletBinding()]
    param (
        [Parameter(Position=0,Mandatory=$true)]
        [String]$InputPath,
        [String]$Delimiter = ";"
    )

    $Superheroes = @{}

    $CsvFile = Import-Csv -Path $InputPath -Delimiter $Delimiter
    foreach ($Item in $CsvFile){
        
        $Superheroes[$Item.Name] = [NewSuperhero]::new(
        $Item.Name, 
        $Item.Alignment,
        $Item.Abilities -split ",",
        $Item.Strength,
        $Item.Armor,
        $Item.Luck,
        $Item.Greed,
        $Item.Level)
    }

    Return $Superheroes

}

$Superheroes = Wrapper-CsvImport -InputPath .\HeroMap2.csv

foreach ($Superhero in $Superheroes.values) {
    Write-Output "`r`nProcessing $($Superhero.Name) ($($Superhero.Alignment)):"
    $DiceRoll = Get-Random -Minimum 1 -Maximum 4
    
    switch ($Superhero.Level) {
        { $_ -lt 10 } {
            Write-Output "Low-level superhero"
            
            switch ($Superhero.Alignment) {
                "Hero" {
                    $ExtraLuck = 2 * $DiceRoll
                    Write-Output "Gains extra luck: $ExtraLuck "
                    $Superhero.Luck += $ExtraLuck
                }
                "Villain" {
                    $ExtraGreed = 2 * $DiceRoll
                    Write-Output "Gains extra greed: $ExtraGreed"
                    $Superhero.Greed += $ExtraGreed
                }
                Default {
                    $ExtraLuck = 1 * $DiceRoll
                    $ExtraGreed = 1 * $DiceRoll
                    Write-Output "Gains extra luck: $ExtraLuck "
                    Write-Output "Gains extra greed: $ExtraGreed"
                    $Superhero.Luck += $ExtraLuck
                    $Superhero.Greed += $ExtraGreed
                }
            }
        }
        { $_ -ge 10 -and $_ -lt 25 } {
            Write-Output "Medium-level superhero"
            
            switch ($Superhero.Alignment) {
                "Hero" {
                    $ExtraLuck = 3 * $DiceRoll
                    Write-Output "Gains extra luck: $ExtraLuck "
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
                    Write-Output "Gains extra luck: $ExtraLuck "
                    Write-Output "Gains extra greed: $ExtraGreed"
                    $Superhero.Luck += $ExtraLuck
                    $Superhero.Greed += $ExtraGreed
                }
            }
        }
        { $_ -ge 25 -and $_ -lt 50 } {
            Write-Output "High-level superhero"
            
            switch ($Superhero.Alignment) {
                "Hero" {
                    $ExtraLuck = 4 * $DiceRoll
                    Write-Output "Gains extra luck: $ExtraLuck "
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
                    Write-Output "Gains extra luck: $ExtraLuck "
                    Write-Output "Gains extra greed: $ExtraGreed"
                    $Superhero.Luck += $ExtraLuck
                    $Superhero.Greed += $ExtraGreed
                }
            }
        }
        Default {
            Write-Output "Max-level superhero"
            # Nested switch block for high-level benefits
            switch ($Superhero.Alignment) {
                Default {
                    Write-Output "Too high powered. No new benefits."
                }
            }
        }
    }

}

Write-Output "Processed all superheroes"

