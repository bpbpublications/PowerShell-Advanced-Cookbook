# Recipe 2.3: Adding Dynamic Parameters to a Function
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates how to add parameters that only appear
# under certain conditions using DynamicParam.

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

    # ========================================================================
    # DYNAMIC PARAMETER BLOCK
    # ========================================================================
    # DynamicParam runs during parameter binding to conditionally add parameters

    DynamicParam {
        # Dictionary to hold all dynamic parameters
        $DynamicParams = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        # Only add flying parameters when Flying ability is selected
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

    # ========================================================================
    # PROCESS BLOCK
    # ========================================================================

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
# USAGE EXAMPLES
# ============================================================================

Write-Output "=== Hero without Flying (no dynamic params) ==="
Add-Superhero -Name "Ground Hero" -Abilities Indestructible -Powers 80

Write-Output ""
Write-Output "=== Hero with Flying (dynamic params required) ==="
Add-Superhero -Name "Sky Hero" -Abilities Flying -Powers 90 -FlyingHeight 500 -FlyingSpeed 200 -Verbose

# Key Concepts:
# - DynamicParam block adds parameters conditionally
# - Access dynamic parameter values via $PSBoundParameters['ParamName']
# - Dynamic parameters enable context-sensitive tab completion
# - RuntimeDefinedParameterDictionary holds all dynamic parameters
