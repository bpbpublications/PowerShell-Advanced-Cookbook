class NewSuperhero {
    [String] $Name
    [String] $Alignment
    [String[]] $Abilities
    [Int] $Strength
    [Int] $Armor
    [Int] $Luck
    [Int] $Greed
    [Int] $Level

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
    }
}

$Comet = [NewSuperhero]::new("Comet", "Hero", @("Flying", "Invulnerability"),75,80,15,5,1)
$Evilin = New-Object NewSuperhero -ArgumentList "Evilin", "Villain", @("Flying","Invulnerability"),60,45,2,20,1

$Comet
$Evilin