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

$Superheroes = Wrapper-CsvImport -InputPath .\HeroMap.csv

$Missions = @("Prevent Nuclear Meltdown", "Defend the City", "Stop Biological Outbreak")

:MissionLoop foreach ($Mission in $Missions) {
    Write-Output "`r`nMission: $Mission`r`n"

    $Heroes = New-Object System.Collections.ArrayList
    $Superheroes.values | Where-Object {$_.Alignment -eq "Hero"} | ForEach-Object { $Heroes += $_.Name }

    $Villains = New-Object System.Collections.ArrayList
    $Superheroes.values | Where-Object {$_.Alignment -eq "Villain"} | ForEach-Object { $Villains += $_.Name }

    :HeroLoop for ($i = 0; $i -lt $Heroes.Count) {

        :VillainLoop for ($j = 0; $j -lt $Villains.Count) {

            # Battle
            $Hero = $Heroes[(Get-Random -min 0 -max $Heroes.Count)]
            $Villain = $Villains[(Get-Random -min 0 -max $Villains.Count)]

            $ChosenHeroStrength = ($Superheroes.$Hero.Strength) + 
                (Get-Random -Minimum 1 -Maximum 50) + 
                ($Superheroes.$Hero.Luck)

            $ChosenVillainArmor = ($Superheroes.$Villain.Armor) + 
                (Get-Random -Minimum 1 -Maximum 50) +
                ($Superheroes.$Villain.Greed)

            # Hero Wins
            if ($ChosenHeroStrength -ge $ChosenVillainArmor) {
                Write-Output "Hero $Hero ($ChosenHeroStrength) defeats $Villain ($ChosenVillainArmor)"
                $Villains.Remove($Villain)

                if ($Villains.Count -eq 0) {
                    Write-Output "`r`nMission Successful: $Mission"
                    continue MissionLoop
                }
                else {
                    continue HeroLoop
                }
            }

            # Villain Wins
            else {
                Write-Output "Villain $Villain ($ChosenVillainArmor) defeats $Hero ($ChosenHeroStrength)"
                $Heroes.Remove($Hero)
                
                if ($Heroes.Count -eq 0) {
                    Write-Output "`r`nMission Failed: $Mission"
                    break HeroLoop
                }
                else {
                    break VillainLoop
                }
            }
        }
    }
}
