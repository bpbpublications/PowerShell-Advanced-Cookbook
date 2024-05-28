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

        $this.AddDefaultPropertyValues()
        $this.AdjustBehavior()

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

}

$Comet = [NewSuperhero]::new("Comet", $null, @("Flying", "Invulnerability"),75,80,"",$null,$null)
$Comet