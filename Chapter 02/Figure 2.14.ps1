# Figure 2.14 - Dynamic parameters that appear based on other parameter values
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates DynamicParam - parameters that only exist under certain conditions.
# When "Flying" is selected as an ability, FlyingHeight and FlyingSpeed become mandatory.

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
    # DynamicParam runs during parameter binding, BEFORE the function body executes.
    # It allows you to conditionally add parameters based on other parameter values.

    DynamicParam {
        # RuntimeDefinedParameterDictionary holds all dynamic parameters
        $DynamicParams = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        # Only add flying-related parameters if Flying ability is selected
        if ($Abilities -contains "Flying") {

            # ----------------------------------------------------------------
            # Create FlyingHeight parameter
            # ----------------------------------------------------------------

            # Step 1: Create the parameter attribute (defines behavior)
            $FlyingHeightAttr = New-Object System.Management.Automation.ParameterAttribute
            $FlyingHeightAttr.ParameterSetName = "__AllParameterSets"  # Available in all parameter sets
            $FlyingHeightAttr.Position = 3
            $FlyingHeightAttr.Mandatory = $true  # Required when Flying is selected

            # Step 2: Create attribute collection (can hold multiple attributes)
            $FlyingHeightColl = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $FlyingHeightColl.Add($FlyingHeightAttr)

            # Step 3: Create the runtime parameter with name, type, and attributes
            $FlyingHeightParam = New-Object System.Management.Automation.RuntimeDefinedParameter(
                'FlyingHeight',   # Parameter name
                [int],            # Parameter type
                $FlyingHeightColl # Attribute collection
            )

            # Step 4: Add to the dictionary
            $DynamicParams.Add('FlyingHeight', $FlyingHeightParam)

            # ----------------------------------------------------------------
            # Create FlyingSpeed parameter (same pattern)
            # ----------------------------------------------------------------

            $FlyingSpeedAttr = New-Object System.Management.Automation.ParameterAttribute
            $FlyingSpeedAttr.ParameterSetName = "__AllParameterSets"
            $FlyingSpeedAttr.Position = 4
            $FlyingSpeedAttr.Mandatory = $true

            $FlyingSpeedColl = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $FlyingSpeedColl.Add($FlyingSpeedAttr)

            $FlyingSpeedParam = New-Object System.Management.Automation.RuntimeDefinedParameter(
                'FlyingSpeed',
                [int],
                $FlyingSpeedColl
            )
            $DynamicParams.Add('FlyingSpeed', $FlyingSpeedParam)
        }

        # Return the dictionary (even if empty)
        return $DynamicParams
    }

    # ============================================================================
    # PROCESS BLOCK
    # ============================================================================
    # Dynamic parameter values are accessed via $PSBoundParameters, not directly

    Process {
        $Object = [PSCustomObject]@{
            Name         = $Name
            Abilities    = $Abilities
            Powers       = $Powers
            # Access dynamic parameters from $PSBoundParameters dictionary
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
# DEMONSTRATE MEMBER DIFFERENCES
# ============================================================================

# Without Flying ability - FlyingHeight and FlyingSpeed are $null
Write-Output "=== Walking Man (no Flying ability) ==="
Add-Superhero -Name "Walking Man" -Powers 80 | Get-Member -MemberType NoteProperty

# Expected Output:
#    TypeName: System.Management.Automation.PSCustomObject
#
# Name         MemberType   Definition
# ----         ----------   ----------
# Abilities    NoteProperty Object[] Abilities=System.Object[]
# FlyingHeight NoteProperty object FlyingHeight=null
# FlyingSpeed  NoteProperty object FlyingSpeed=null
# Name         NoteProperty string Name=Walking Man
# Powers       NoteProperty int Powers=80

Write-Output ""
Write-Output "=== Flying Man (with Flying ability) ==="
Add-Superhero -Name "Flying Man" -Abilities Flying -Powers 80 -FlyingHeight 100 -FlyingSpeed 32 | Get-Member -MemberType NoteProperty

# Expected Output:
#    TypeName: System.Management.Automation.PSCustomObject
#
# Name         MemberType   Definition
# ----         ----------   ----------
# Abilities    NoteProperty Object[] Abilities=System.Object[]
# FlyingHeight NoteProperty int FlyingHeight=100
# FlyingSpeed  NoteProperty int FlyingSpeed=32
# Name         NoteProperty string Name=Flying Man
# Powers       NoteProperty int Powers=80

# Key Concepts:
# - DynamicParam block runs during parameter binding (before Begin/Process/End)
# - RuntimeDefinedParameterDictionary holds all dynamic parameters
# - Each dynamic parameter needs: ParameterAttribute, AttributeCollection, RuntimeDefinedParameter
# - Access dynamic parameter values via $PSBoundParameters['ParameterName']
# - Dynamic parameters provide context-sensitive tab completion
# - __AllParameterSets makes the parameter available regardless of which parameter set is used
