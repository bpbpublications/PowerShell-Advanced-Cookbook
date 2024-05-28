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

$Comet = [NewSuperhero]::new("Comet", "Hero", @("Flying", "Invulnerability"),75,80,"",$null,$null)
$Comet