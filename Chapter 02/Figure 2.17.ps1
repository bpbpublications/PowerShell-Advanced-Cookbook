# Figure 2.17 - Parameter sets with Begin/Process/End blocks for collection building
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates using parameter sets combined with lifecycle blocks.
# Begin initializes a collection, Process adds items, End returns the complete collection.

function Add-Superhero {
    [CmdletBinding(DefaultParameterSetName = "Neutral")]
    param (
        # Shared parameters (available in all parameter sets)
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "__AllParameterSets")]
        [ValidateNotNullOrEmpty()]
        [String]$Name,

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
        [int]$Greed = 5,

        # Hero parameter set
        [Parameter(Position = 1, ParameterSetName = "Hero")]
        [ValidateSet("Force Field Generation", "Telepathy", "Healing", "Precognition", "Super Speed")]
        [String[]]$HeroAbilities,

        # Villain parameter set
        [Parameter(Position = 1, ParameterSetName = "Villain")]
        [ValidateSet("Energy Drain", "Pyrokinesis", "Darkness Manipulation", "Necromancy", "Mind Control")]
        [String[]]$VillainAbilities
    )

    # ========================================================================
    # DYNAMIC PARAMETERS
    # ========================================================================

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
    # BEGIN BLOCK - Runs once before processing any pipeline input
    # ========================================================================

    Begin {
        # Initialize a hashtable to collect all superheroes
        # Using hashtable allows lookup by name: $Superheroes["Captain Battle"]
        $Superheroes = @{}
        Write-Verbose "Initialized superhero collection"
    }

    # ========================================================================
    # PROCESS BLOCK - Runs once for each pipeline input
    # ========================================================================

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

        # Create the superhero object
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

        # Add to our collection hashtable (keyed by name)
        $Superheroes[$Name] = $Object

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
    }

    # ========================================================================
    # END BLOCK - Runs once after all pipeline input is processed
    # ========================================================================

    End {
        Write-Verbose "Returning collection with $($Superheroes.Count) superheroes"
        # Return the complete collection
        return $Superheroes
    }
}

# ============================================================================
# BUILD A SUPERHERO ROSTER
# ============================================================================

Write-Output "=== Building Superhero Roster ==="

# Each call adds one hero to the collection returned from End block
# We accumulate them using += on an external hashtable
$Superheroes = @{}
$Superheroes += (Add-Superhero -Name "Captain Battle" -Abilities "Invulnerability" `
    -HeroAbilities "Super Speed" -Verbose)
$Superheroes += (Add-Superhero -Name "Red Rube" -VillainAbilities "Pyrokinesis" -Verbose)
$Superheroes += (Add-Superhero -Name "Moon Girl" -Abilities "Flying" `
    -FlyingHeight 384400000 -FlyingSpeed 5000 -Verbose)

# ============================================================================
# VIEW THE COMPLETE ROSTER
# ============================================================================

Write-Output ""
Write-Output "=== Complete Roster ==="
$Superheroes

# Expected Output:
# Name                           Value
# ----                           -----
# Captain Battle                 @{Name=Captain Battle; Alignment=Hero; ...}
# Red Rube                       @{Name=Red Rube; Alignment=Villain; ...}
# Moon Girl                      @{Name=Moon Girl; Alignment=Neutral; ...}

# Note: Moon Girl is Neutral because she only used -Abilities (no Hero/Villain abilities)

# Key Concepts:
# - Begin block initializes resources before processing starts
# - Process block handles each item (in this case, each function call)
# - End block finalizes and returns results after all processing
# - Hashtable allows O(1) lookup by key: $Superheroes["Captain Battle"]
# - += merges hashtables together to build a complete roster
