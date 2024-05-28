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

$Monster = [NewSuperhero]::new("Monster",$null,@(),52,63,0,0,25)
$Monster | Add-Member -NotePropertyName HitPoints -NotePropertyValue 1000

$Hero = $Superheroes."Alias X"
$Hero | Add-Member -NotePropertyName HitPoints -NotePropertyValue 780

function RollDice {
    return Get-Random -Minimum 50 -Maximum 100
}

$Defeated = $false
:Outer while (-not $Defeated){

    :Center do{

        Write-Output "$($Hero.Name) is attacking the monster"

        $Roll = RollDice
        :Inner while ($Roll -lt $Monster.Armor){
            Write-Output "Hero misses ($($Roll) vs. $($Monster.Armor))"
            Write-Output "Monster retaliates"
            
            $MonsterRoll = RollDice
            if ($MonsterRoll -gt $Hero.Armor){
                $Hero.HitPoints -= $MonsterRoll

                Write-host "Monster hits hero with $MonsterRoll (Left: $($Hero.HitPoints))"

                if ($Hero.HitPoints -le 0){
                    Write-Output "Hero is defeated"
                    break Outer
                }
                else{
                    continue Center
                }
            }
            else {
                Write-Output "Monster misses"
                continue Center
            }
            
        }

        $Hit = ($Hero.Strength) + ($Roll)
        $Monster.HitPoints -= $Hit
        
        Write-Output "Hero hit monster with $hit (Left: $($Monster.HitPoints))"
        

    }
    while($Monster.HitPoints -gt 0)

    Write-Output "Monster is defeated"
    $Defeated = $true
}
