function Remove-Superhero {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [String[]]$Name,
        [Parameter(Position = 1)]
        [String]$HeroesVariable = "Heroes"
    )

    Begin {
        if (-not (Get-Variable -Name $HeroesVariable -Scope Global -ErrorAction SilentlyContinue)) {
            throw "Global variable '$HeroesVariable' not found."
        }

        $Heroes = Get-Variable -Name $HeroesVariable -Scope Global -ValueOnly
        $Changes = $false
    }

    Process {
        if (-not $Heroes.ContainsKey("$Name")) {
            Write-Verbose "$HeroesVariable does not contain a Superhero name: $Name"
            Return
        }
        elseif ($PSCmdlet.ShouldProcess("$Name")) {
            $Heroes.Remove("$Name")
            Write-Verbose "Superhero: $Name removed"
            $Changes = $true
        }
    }

    End {
        if ($Changes){
            Write-Verbose "Removed Superheroes from and updated the global variable: $HeroesVariable"
        }
        else{
            Write-Verbose "No changes where made to the global variable: $HeroesVariable"
        }
    }
}

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


$Data = Import-Csv .\Figure_2.21_HeroMap.csv -Delimiter ";"
$Heroes = $Data | Add-Superhero -Verbose


"Comet","Blue Ghost" | Remove-Superhero -Verbose
$Heroes
$Heroes.count