# Recipe 2.4: Adding Parameter Sets with Alignment
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates using parameter sets to create mutually
# exclusive parameter groups with Hero/Villain/Neutral alignments.

function Add-Superhero {
    # DefaultParameterSetName specifies which set to use when none is explicit
    [CmdletBinding(DefaultParameterSetName = "Neutral")]
    param (
        # __AllParameterSets makes this parameter available in every set
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "__AllParameterSets")]
        [ValidateNotNullOrEmpty()]
        [String]$Name,

        # Hero parameter set - exclusive hero abilities
        [Parameter(Position = 1, ParameterSetName = "Hero")]
        [ValidateSet("Force Field Generation", "Telepathy", "Healing", "Precognition", "Super Speed")]
        [String[]]$HeroAbilities,

        # Villain parameter set - exclusive villain abilities
        [Parameter(Position = 1, ParameterSetName = "Villain")]
        [ValidateSet("Energy Drain", "Pyrokinesis", "Darkness Manipulation", "Necromancy", "Mind Control")]
        [String[]]$VillainAbilities,

        # Shared abilities available in all parameter sets
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

    # Dynamic parameters for Flying ability
    DynamicParam {
        $DynamicParams = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        if ($Abilities -contains "Flying") {
            $FlyingHeightAttr = New-Object System.Management.Automation.ParameterAttribute
            $FlyingHeightAttr.ParameterSetName = "__AllParameterSets"
            $FlyingHeightAttr.Position = 4
            $FlyingHeightAttr.Mandatory = $true

            $FlyingHeightColl = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $FlyingHeightColl.Add($FlyingHeightAttr)

            $FlyingHeightParam = New-Object System.Management.Automation.RuntimeDefinedParameter(
                'FlyingHeight', [int], $FlyingHeightColl
            )
            $DynamicParams.Add('FlyingHeight', $FlyingHeightParam)

            $FlyingSpeedAttr = New-Object System.Management.Automation.ParameterAttribute
            $FlyingSpeedAttr.ParameterSetName = "__AllParameterSets"
            $FlyingSpeedAttr.Position = 5
            $FlyingSpeedAttr.Mandatory = $true

            $FlyingSpeedColl = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $FlyingSpeedColl.Add($FlyingSpeedAttr)

            $FlyingSpeedParam = New-Object System.Management.Automation.RuntimeDefinedParameter(
                'FlyingSpeed', [int], $FlyingSpeedColl
            )
            $DynamicParams.Add('FlyingSpeed', $FlyingSpeedParam)
        }

        return $DynamicParams
    }

    Process {
        # Determine alignment based on which parameter set was used
        if ($PSCmdlet.ParameterSetName -eq "Hero") {
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
        else {
            $Alignment = "Neutral"
            $AllAbilities = $Abilities
            $Luck += 2
            $Greed += 2
        }

        $Object = [PSCustomObject]@{
            Name         = $Name
            Alignment    = $Alignment
            Abilities    = $AllAbilities
            Strength     = $Strength
            Luck         = $Luck
            Greed        = $Greed
            FlyingHeight = $PSBoundParameters['FlyingHeight']
            FlyingSpeed  = $PSBoundParameters['FlyingSpeed']
        }

        Write-Verbose "Created Superhero with the name: $Name"
        Write-Verbose "$Name is a $Alignment"
        Write-Verbose "$Name was given the following abilities: $AllAbilities"
        Write-Verbose "$Name has a strength of: $Strength, Luck of: $Luck and Greed of: $Greed"

        if ($Object.FlyingHeight) {
            Write-Verbose "$Name can fly at a height of $($Object.FlyingHeight) meters."
        }
        if ($Object.FlyingSpeed) {
            Write-Verbose "$Name can fly at a speed of $($Object.FlyingSpeed) km/h."
        }

        return $Object
    }
}

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

Write-Output "=== Creating a Hero ==="
Add-Superhero -Name "Captain Good" -HeroAbilities Healing -Verbose

Write-Output ""
Write-Output "=== Creating a Villain ==="
Add-Superhero -Name "Dark Lord" -VillainAbilities Necromancy, "Mind Control" -Verbose

Write-Output ""
Write-Output "=== Creating a Neutral Character ==="
Add-Superhero -Name "Gray Ghost" -Abilities "Super Strength" -Verbose

# Key Concepts:
# - Parameter sets create mutually exclusive groups
# - $PSCmdlet.ParameterSetName identifies which set was used
# - DefaultParameterSetName handles cases where no set-specific param is given
# - Cannot use -HeroAbilities and -VillainAbilities together
