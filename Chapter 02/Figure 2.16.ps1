# Figure 2.16 - Parameter sets for mutually exclusive parameter groups
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates parameter sets - mutually exclusive groups of parameters.
# A character can be a Hero, Villain, or Neutral, but not multiple at once.

function Add-Superhero {
    # DefaultParameterSetName determines which set is used when none is specified
    [CmdletBinding(DefaultParameterSetName = "Neutral")]
    param (
        # ====================================================================
        # PARAMETERS IN __AllParameterSets (available in ALL parameter sets)
        # ====================================================================

        # __AllParameterSets is a special name - parameter is available everywhere
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "__AllParameterSets")]
        [ValidateNotNullOrEmpty()]
        [String]$Name,

        # Shared abilities available to any alignment
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

        # ====================================================================
        # HERO PARAMETER SET - Exclusive hero abilities
        # ====================================================================

        [Parameter(Position = 1, ParameterSetName = "Hero")]
        [ValidateSet("Force Field Generation", "Telepathy", "Healing", "Precognition", "Super Speed")]
        [String[]]$HeroAbilities,

        # ====================================================================
        # VILLAIN PARAMETER SET - Exclusive villain abilities
        # ====================================================================

        [Parameter(Position = 1, ParameterSetName = "Villain")]
        [ValidateSet("Energy Drain", "Pyrokinesis", "Darkness Manipulation", "Necromancy", "Mind Control")]
        [String[]]$VillainAbilities
    )

    # ========================================================================
    # DYNAMIC PARAMETERS (conditional on Flying ability)
    # ========================================================================

    DynamicParam {
        $DynamicParams = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        if ($Abilities -contains "Flying") {
            # Create FlyingHeight dynamic parameter
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

            # Create FlyingSpeed dynamic parameter
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
    # PROCESS BLOCK - Logic varies based on parameter set
    # ========================================================================

    Process {
        # $PSCmdlet.ParameterSetName tells us which parameter set was used
        if ($PSCmdlet.ParameterSetName -eq "Hero") {
            $Alignment = "Hero"
            $AllAbilities = $Abilities + $HeroAbilities
            $Luck += 5   # Heroes are lucky
            $Greed -= 5  # Heroes are selfless
        }
        elseif ($PSCmdlet.ParameterSetName -eq "Villain") {
            $Alignment = "Villain"
            $AllAbilities = $Abilities + $VillainAbilities
            $Luck -= 5   # Villains have bad luck (karma!)
            $Greed += 5  # Villains are greedy
        }
        else {
            # Neutral (default) - no hero or villain abilities specified
            $Alignment = "Neutral"
            $AllAbilities = $Abilities
            $Luck += 2   # Neutral characters get modest bonuses
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
# EXAMPLE 1: VILLAIN (uses Villain parameter set)
# ============================================================================

Write-Output "=== Creating a Villain ==="
Add-Superhero -Name "Evilin" -VillainAbilities "Necromancy", "Energy Drain" `
    -Abilities "Invulnerability" -Verbose

# Expected Output:
# VERBOSE: Created Superhero with the name: Evilin
# VERBOSE: Evilin is a Villain
# VERBOSE: Evilin was given the following abilities: Invulnerability Necromancy Energy Drain
# VERBOSE: Evilin has a strength of: 10, Luck of: 0 and Greed of: 10
#
# Name    : Evilin
# Alignment : Villain
# Abilities : {Invulnerability, Necromancy, Energy Drain}
# Strength  : 10
# Luck      : 0
# Greed     : 10

# ============================================================================
# EXAMPLE 2: HERO (uses Hero parameter set)
# ============================================================================

Write-Output ""
Write-Output "=== Creating a Hero ==="
Add-Superhero -Name "Amazing Man" -HeroAbilities "Healing", "Super Speed" `
    -Abilities "Invulnerability", "Flying" -FlyingHeight 1000 -FlyingSpeed 500 -Verbose

# Expected Output:
# VERBOSE: Created Superhero with the name: Amazing Man
# VERBOSE: Amazing Man is a Hero
# VERBOSE: Amazing Man was given the following abilities: Invulnerability Flying Healing Super Speed
# VERBOSE: Amazing Man has a strength of: 10, Luck of: 10 and Greed of: 0
# VERBOSE: Amazing Man can fly at a height of 1000 meters.
# VERBOSE: Amazing Man can fly at a speed of 500 km/h.

# ============================================================================
# EXAMPLE 3: NEUTRAL (default parameter set)
# ============================================================================

Write-Output ""
Write-Output "=== Creating a Neutral Character ==="
Add-Superhero -Name "Blue Ghost" -Abilities "Super Strength" -Luck 25 -Greed 25 -Verbose

# Expected Output:
# VERBOSE: Created Superhero with the name: Blue Ghost
# VERBOSE: Blue Ghost is a Neutral
# VERBOSE: Blue Ghost was given the following abilities: Super Strength
# VERBOSE: Blue Ghost has a strength of: 10, Luck of: 27 and Greed of: 27

# Key Concepts:
# - Parameter sets create mutually exclusive groups (-HeroAbilities OR -VillainAbilities, not both)
# - DefaultParameterSetName defines which set is used when no set-specific parameter is provided
# - __AllParameterSets makes a parameter available in ALL parameter sets
# - $PSCmdlet.ParameterSetName tells you which set was actually used at runtime
# - Tab completion will only show relevant parameters based on which set you're using
# - Cannot use -HeroAbilities and -VillainAbilities together (try it - you'll get an error!)
