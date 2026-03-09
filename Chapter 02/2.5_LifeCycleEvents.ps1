# Recipe 2.5: Lifecycle Events (Begin, Process, End)
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates the three lifecycle blocks that control
# how a function processes pipeline input.

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

    # Dynamic parameters for Flying
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

    # ========================================================================
    # BEGIN BLOCK - Runs ONCE before any pipeline processing
    # ========================================================================
    # Use Begin to initialize resources, create collections, open connections

    Begin {
        # Initialize hashtable to collect all superheroes
        $Superheroes = @{}
        Write-Verbose "BEGIN: Initialized superhero collection"
    }

    # ========================================================================
    # PROCESS BLOCK - Runs ONCE for each pipeline object
    # ========================================================================
    # Use Process to handle each individual item

    Process {
        # Determine alignment based on parameter set
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

        # Add to collection
        $Superheroes[$Name] = $Object

        Write-Verbose "PROCESS: Created Superhero: $Name ($Alignment)"
        Write-Verbose "PROCESS: Abilities: $AllAbilities"
        Write-Verbose "PROCESS: Stats - Strength: $Strength, Luck: $Luck, Greed: $Greed"

        if ($Object.FlyingHeight) {
            Write-Verbose "PROCESS: $Name can fly at $($Object.FlyingHeight)m at $($Object.FlyingSpeed)km/h"
        }
    }

    # ========================================================================
    # END BLOCK - Runs ONCE after all pipeline processing is complete
    # ========================================================================
    # Use End to return results, close connections, cleanup resources

    End {
        Write-Verbose "END: Returning $($Superheroes.Count) superheroes"
        return $Superheroes
    }
}

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

Write-Output "=== Creating Multiple Superheroes ==="

# Each call adds to the collection returned in End block
$AllHeroes = @{}
$AllHeroes += (Add-Superhero -Name "Captain Good" -HeroAbilities Healing -Verbose)
$AllHeroes += (Add-Superhero -Name "Dark Lord" -VillainAbilities Necromancy -Verbose)
$AllHeroes += (Add-Superhero -Name "Gray Ghost" -Abilities "Super Strength" -Verbose)

Write-Output ""
Write-Output "=== Complete Roster ==="
$AllHeroes

# Key Concepts:
# - Begin: Initialize resources ONCE before processing
# - Process: Handle EACH pipeline item
# - End: Finalize and return ONCE after all processing
# - Without Process block, only the last pipeline item is processed
# - Variables declared in Begin are accessible in Process and End
