# Figure 2.15 - Dynamic parameters with verbose output demonstration
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates calling a function with dynamic parameters and viewing
# verbose output to understand the internal workflow.

function Add-Superhero {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$Name,

        [Parameter(Position = 1)]
        [ValidateSet("Flying", "Indestructible", "LaserEyes")]
        [String[]]$Abilities = "None",

        [Parameter(Position = 2, Mandatory = $false)]
        [ValidateRange(0, 100)]
        [Int]$Powers = 10
    )

    # ============================================================================
    # DYNAMIC PARAMETER BLOCK
    # ============================================================================
    # Conditionally adds FlyingHeight and FlyingSpeed when "Flying" is selected

    DynamicParam {
        $DynamicParams = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        if ($Abilities -contains "Flying") {
            # FlyingHeight parameter
            $FlyingHeightAttr = New-Object System.Management.Automation.ParameterAttribute
            $FlyingHeightAttr.ParameterSetName = "__AllParameterSets"
            $FlyingHeightAttr.Position = 3
            $FlyingHeightAttr.Mandatory = $true

            $FlyingHeightColl = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $FlyingHeightColl.Add($FlyingHeightAttr)

            $FlyingHeightParam = New-Object System.Management.Automation.RuntimeDefinedParameter(
                'FlyingHeight', [int], $FlyingHeightColl
            )
            $DynamicParams.Add('FlyingHeight', $FlyingHeightParam)

            # FlyingSpeed parameter
            $FlyingSpeedAttr = New-Object System.Management.Automation.ParameterAttribute
            $FlyingSpeedAttr.ParameterSetName = "__AllParameterSets"
            $FlyingSpeedAttr.Position = 4
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
        $Object = [PSCustomObject]@{
            Name         = $Name
            Abilities    = $Abilities
            Powers       = $Powers
            FlyingHeight = $PSBoundParameters['FlyingHeight']
            FlyingSpeed  = $PSBoundParameters['FlyingSpeed']
        }

        Write-Verbose "Created Superhero with the name: $Name"
        Write-Verbose "$Name was given the following abilities: $Abilities"
        Write-Verbose "$Name has a power of: $Powers"

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
# EXAMPLE 1: HERO WITHOUT FLYING ABILITY
# ============================================================================

Write-Output "=== Creating Walking Man (no Flying) ==="
$WalkingMan = Add-Superhero -Name "Walking Man" -Powers 80 -Verbose
$WalkingMan

# Expected Output:
# VERBOSE: Created Superhero with the name: Walking Man
# VERBOSE: Walking Man was given the following abilities: None
# VERBOSE: Walking Man has a power of: 80
#
# Name         Abilities Powers FlyingHeight FlyingSpeed
# ----         --------- ------ ------------ -----------
# Walking Man  {None}        80

# Note: FlyingHeight and FlyingSpeed are not displayed because they're $null

# ============================================================================
# EXAMPLE 2: HERO WITH FLYING ABILITY (REQUIRES DYNAMIC PARAMETERS)
# ============================================================================

Write-Output ""
Write-Output "=== Creating Flying Man (with Flying) ==="

# Try this WITHOUT the dynamic parameters to see the error:
# Add-Superhero -Name "Flying Man" -Abilities Flying -Powers 80
# Error: Missing mandatory parameter: FlyingHeight

$FlyingMan = Add-Superhero -Name "Flying Man" -Abilities Flying -Powers 80 `
    -FlyingHeight 500 -FlyingSpeed 120 -Verbose
$FlyingMan

# Expected Output:
# VERBOSE: Created Superhero with the name: Flying Man
# VERBOSE: Flying Man was given the following abilities: Flying
# VERBOSE: Flying Man has a power of: 80
# VERBOSE: Flying Man can fly at a height of 500 meters.
# VERBOSE: Flying Man can fly at a speed of 120 km/h.
#
# Name       Abilities Powers FlyingHeight FlyingSpeed
# ----       --------- ------ ------------ -----------
# Flying Man {Flying}      80          500         120

# ============================================================================
# EXAMPLE 3: MULTIPLE ABILITIES INCLUDING FLYING
# ============================================================================

Write-Output ""
Write-Output "=== Creating Super Hero (multiple abilities) ==="
$SuperHero = Add-Superhero -Name "Ultra" -Abilities Flying, LaserEyes -Powers 95 `
    -FlyingHeight 1000 -FlyingSpeed 200 -Verbose
$SuperHero

# Expected Output:
# VERBOSE: Created Superhero with the name: Ultra
# VERBOSE: Ultra was given the following abilities: Flying LaserEyes
# VERBOSE: Ultra has a power of: 95
# VERBOSE: Ultra can fly at a height of 1000 meters.
# VERBOSE: Ultra can fly at a speed of 200 km/h.
#
# Name  Abilities          Powers FlyingHeight FlyingSpeed
# ----  ---------          ------ ------------ -----------
# Ultra {Flying, LaserEyes}    95         1000         200

# Key Concepts:
# - Dynamic parameters appear in IntelliSense only when conditions are met
# - -Verbose shows the internal workflow and helps debugging
# - Dynamic mandatory parameters enforce requirements based on context
# - The $PSBoundParameters automatic variable contains all bound parameters
