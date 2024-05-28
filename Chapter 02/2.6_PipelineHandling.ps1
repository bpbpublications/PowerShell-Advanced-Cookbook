function Add-Superhero {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [String]$Name,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)]
        [ValidateSet("Hero", "Villain", "Neutral")]
        [String]$Alignment,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName)]
        [String[]]$Abilities,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName)]
        [ValidateRange(0, 100)]
        [Int]$Strength = 10,
        [Parameter(Position = 4, ValueFromPipelineByPropertyName)]
        [ValidateRange(0, 100)]
        [Int]$Armor = 10,
        [Parameter(Position = 5, ValueFromPipelineByPropertyName)]
        [ValidateRange(0, 50)]
        [int]$Luck = 5,
        [Parameter(Position = 6, ValueFromPipelineByPropertyName)]
        [ValidateRange(0, 50)]
        [int]$Greed = 5
    )

    Begin{
        $Superheroes = @{}
    }

    Process {

        switch ($Alignment) {
            "Hero" { $Luck += 5
                     $Greed -= 5 }
            "Villain" { $Luck -= 5
                        $Greed += 5 }
            Default { $Luck += 3
                      $Greed += 3 }
        }

        $Object = [PSCustomObject]@{
            Abilities = $Abilities -split ","
            Alignment = $Alignment
            Name = $Name
            Strength = $Strength
            Armor = $Armor
            Luck = $Luck
            Greed = $Greed
        }

        $Superheroes[$Name] = $Object

        Write-Verbose "Created Superhero with the name: $Name"
        Write-Verbose "$Name is a $Alignment"
        Write-Verbose "$Name was given the following abilities: $Abilities"
        Write-Verbose "$Name has a strength of: $Strength, Armor of: $Armor, Luck of: $Luck and Greed of: $Greed`r`n"
    }

    End{        
        return $Superheroes
    }
}

$Data = Import-Csv .\HeroMap.csv -Delimiter ";"
$Heroes = $Data | Add-Superhero -Verbose
$Heroes


