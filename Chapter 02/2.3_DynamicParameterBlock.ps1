# Dynamic Parameter Block - Code Snippet
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications
#
# This snippet shows the structure of a DynamicParam block
# for adding conditional parameters to functions.

# ============================================================================
# DYNAMIC PARAMETER BLOCK TEMPLATE
# ============================================================================

DynamicParam {
    # Create dictionary to hold dynamic parameters
    $DynamicParams = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

    # Condition that triggers the dynamic parameter (e.g., based on other parameter values)
    if ($Abilities -contains "Flying") {

        # STEP 1: Create parameter attribute
        $FlyingHeightAttr = New-Object System.Management.Automation.ParameterAttribute
        $FlyingHeightAttr.ParameterSetName = "__AllParameterSets"  # Available in all sets
        $FlyingHeightAttr.Position = 3                              # Positional order
        $FlyingHeightAttr.Mandatory = $true                         # Required parameter

        # STEP 2: Create attribute collection (can include validation attributes)
        $FlyingHeightColl = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $FlyingHeightColl.Add($FlyingHeightAttr)

        # STEP 3: Create the runtime parameter (name, type, attributes)
        $FlyingHeightParam = New-Object System.Management.Automation.RuntimeDefinedParameter(
            'FlyingHeight',   # Parameter name
            [int],            # Parameter type
            $FlyingHeightColl # Attribute collection
        )

        # STEP 4: Add to the dictionary
        $DynamicParams.Add('FlyingHeight', $FlyingHeightParam)

        # Repeat for additional dynamic parameters...
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

    # STEP 5: Return the dictionary (even if empty)
    return $DynamicParams
}

# Key Concepts:
# - DynamicParam runs during parameter binding (before Begin/Process/End)
# - Each dynamic parameter requires: ParameterAttribute, Collection, RuntimeDefinedParameter
# - Access values in function body via $PSBoundParameters['ParameterName']
# - __AllParameterSets makes parameter available regardless of parameter set
