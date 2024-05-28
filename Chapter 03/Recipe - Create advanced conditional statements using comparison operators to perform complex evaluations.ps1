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

# Name      : Tornado Tim
# Alignment : Hero
# Abilities : {Pyrokinesis, Mind Control}
# Strength  : 59
# Armor     : 54
# Luck      : 27
# Greed     : 21
# Level     : 1
# Flying    : False

# Name      : Chiss
# Alignment : Villain
# Abilities : {Telepathy, Invulnerability}
# Strength  : 45
# Armor     : 70
# Luck      : 5
# Greed     : 26
# Level     : 1
# Flying    : False

$Superheroes = Wrapper-CsvImport -InputPath .\HeroMap.csv

$Hero = $Superheroes."Tornado Tim"
$Villain = $Superheroes."Chiss"

$HeroDiceRoll = Get-Random -Minimum 1 -Maximum 50
$VillainDiceRoll = Get-Random -Minimum 1 -Maximum 50

( ($Hero.Strength + $Hero.luck) -gt $Villain.Armor ) -and ( ($Hero.Greed + $HeroDiceRoll) -lt ($Villain.Greed + $VillainDiceRoll) ) -and ( ($Hero.Luck + $HeroDiceRoll) -gt ($Villain.Luck + $VillainDiceRoll) )
#$Hero.Strength + $Hero.luck -gt $Villain.Armor -and $Hero.Greed + $HeroDiceRoll -lt $Villain.Greed + $VillainDiceRoll -and $Hero.Luck + $HeroDiceRoll -gt $Villain.Luck + $VillainDiceRoll

function WhatAmI ([int]$Age){
    if ($Age -lt 13){
        Write-Output "You are a child"
    }
    elseif ($Age -ge 13 -and $Age -lt 20){
        Write-Output "You are a teenager"
    }
    elseif ($Age -ge 20){
        Write-Output "You are an adult"
    }
}


# Simulate the hero attacking multiple times
$NumberOfSimulations = 0
$HeroHits = 0
while ($NumberOfSimulations -lt 10000){ 
    $HeroDiceRoll = Get-Random -Minimum 1 -Maximum 50
    $VillainDiceRoll = Get-Random -Minimum 1 -Maximum 50
    
    # Check if the Hero hits the villain based on the provided condition
    if (( ($Hero.Strength + $Hero.luck) -gt $Villain.Armor ) -and ( ($Hero.Greed + $HeroDiceRoll) -lt ($Villain.Greed + $VillainDiceRoll) ) -and ( ($Hero.Luck + $HeroDiceRoll) -gt ($Villain.Luck + $VillainDiceRoll) )) {
        $HeroHits++
    }
    $NumberOfSimulations++
}

# Calculate the chance of the hero successfully landing a hit
[int]$ChanceOfHeroHit = ($HeroHits / $NumberOfSimulations) * 100
Write-Output "The chance of the hero successfully landing a hit is: $ChanceOfHeroHit %"

$VillainArray = "Chiss", "Manx", "Torque"
$HeroArray = "Tornado Tim", "Destiny", "Alias X"
# Statement evaluates to $true
("Chiss" -notin $HeroArray -and "Chiss" -in $VillainArray)

#Evaluates to $true
($HeroArray.GetType().BaseType.Name -eq "array")