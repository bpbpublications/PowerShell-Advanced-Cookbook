function Add-Superhero {
    [CmdletBinding(DefaultParameterSetName = "Neutral")]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "__AllParameterSets")]
        [ValidateNotNullOrEmpty()]
        [String]$Name,

        [Parameter(Position = 1, ParameterSetName = "Hero")]
        [ValidateSet("Force Field Generation", "Telepathy", "Healing", "Precognition", "Super Speed")]
        [String[]]$HeroAbilities,

        [Parameter(Position = 1, ParameterSetName = "Villain")]
        [ValidateSet("Energy Drain", "Pyrokinesis", "Darkness Manipulation", "Necromancy", "Mind Control")]
        [String[]]$VillainAbilities,

        [Parameter(Position = 2, ParameterSetName = "__AllParameterSets")]
        [ValidateSet("Flying", "Invulnerability", "Super Strength")]
        [String[]]$Abilities = "",

        [Parameter(Position = 3, Mandatory = $false, ParameterSetName = "__AllParameterSets")]
        [ValidateRange(0, 100)]
        [Int]$Strength = 10,

        [Parameter(ParameterSetName = "__AllParameterSets")]
        [ValidateRange(0, 50)]
        [int]$Luck = 5,

        [Parameter(ParameterSetName = "__AllParameterSets")]
        [ValidateRange(0, 50)]
        [int]$Greed = 5
    )

    DynamicParam {
        $DynamicParams = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        if ($Abilities -contains "Flying") {
            $FlyingHeightAttr = New-Object System.Management.Automation.ParameterAttribute
            $FlyingHeightAttr.ParameterSetName = "__AllParameterSets"
            $FlyingHeightAttr.Position = 4
            $FlyingHeightAttr.Mandatory = $true

            $FlyingHeightColl = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $FlyingHeightColl.Add($FlyingHeightAttr)

            $FlyingHeightParam = New-Object System.Management.Automation.RuntimeDefinedParameter('FlyingHeight', [int], $FlyingHeightColl)
            $DynamicParams.Add('FlyingHeight', $FlyingHeightParam)

            $FlyingSpeedAttr = New-Object System.Management.Automation.ParameterAttribute
            $FlyingSpeedAttr.ParameterSetName = "__AllParameterSets"
            $FlyingSpeedAttr.Position = 5
            $FlyingSpeedAttr.Mandatory = $true

            $FlyingSpeedColl = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $FlyingSpeedColl.Add($FlyingSpeedAttr)

            $FlyingSpeedParam = New-Object System.Management.Automation.RuntimeDefinedParameter('FlyingSpeed', [int], $FlyingSpeedColl)
            $DynamicParams.Add('FlyingSpeed', $FlyingSpeedParam)
        }

        return $DynamicParams
    }
    Begin{

        $Superheroes = @{}

    }

    Process {
        if ($PSCmdlet.ParameterSetName -eq "Hero"){
            $Alignment = "Hero"
            $AllAbilities = $Abilities + $HeroAbilities
            $Luck += 5
            $Greed -= 5
        }
        elseif ($PSCmdlet.ParameterSetName -eq "Villain") {
            $Alignment = "Villain"
            $AllAbilities = $Abilities + $VillainAbilities
            $Luck -= 5
            $Greed += 5
        }
        else{
            $Alignment = "Neutral"
            $AllAbilities = $Abilities
            $Luck +=2
            $Greed += 2
        }

        $Object = [PSCustomObject]@{
            Abilities = $AllAbilities
            Alignment = $Alignment
            Name = $Name
            Strength = $Strength
            Luck = $Luck
            Greed = $Greed
            FlyingHeight = $PSBoundParameters['FlyingHeight']
            FlyingSpeed = $PSBoundParameters['FlyingSpeed']
        }

        $Superheroes[$Name] = $Object

        Write-Verbose "Created Superhero with the name: $Name"
        Write-Verbose "$Name is a $Alignment"
        Write-Verbose "$Name was given the following abilities: $AllAbilities"
        Write-Verbose "$Name has a strength of: $Strength, Luck of: $Luck and Greed of: $Greed`r`n"

        if ($Object.FlyingHeight) {
            Write-Verbose "$Name can fly at a height of $($Object.FlyingHeight) meters."
        }

        if ($Object.FlyingSpeed) {
            Write-Verbose "$Name can fly at a speed of $($Object.FlyingSpeed) km/h."
        }

    }

    End{
        
        return $Superheroes

    }
}

$Superheroes = @{}
$Superheroes += (Add-Superhero -Name "Captain Battle" -Abilities "invulnerability" -HeroAbilities "Super Speed" -Verbose)
$Superheroes += (Add-Superhero -Name "Red Rube" -VillainAbilities "Pyrokinesis" -Verbose)
$Superheroes += (Add-Superhero -Name "Moon Girl" -Abilities "Flying" -FlyingHeight 384400000 -FlyingSpeed 5000 -Verbose)
$Superheroes