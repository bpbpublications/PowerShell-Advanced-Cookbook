DynamicParam {
    $DynamicParams = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

    if ($Abilities -contains "Flying") {
        $FlyingHeightAttr = New-Object System.Management.Automation.ParameterAttribute
        $FlyingHeightAttr.ParameterSetName = "__AllParameterSets"
        $FlyingHeightAttr.Position = 3
        $FlyingHeightAttr.Mandatory = $true

        $FlyingHeightColl = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $FlyingHeightColl.Add($FlyingHeightAttr)

        $FlyingHeightParam = New-Object System.Management.Automation.RuntimeDefinedParameter('FlyingHeight', [int], $FlyingHeightColl)
        $DynamicParams.Add('FlyingHeight', $FlyingHeightParam)

        $FlyingSpeedAttr = New-Object System.Management.Automation.ParameterAttribute
        $FlyingSpeedAttr.ParameterSetName = "__AllParameterSets"
        $FlyingSpeedAttr.Position = 4
        $FlyingSpeedAttr.Mandatory = $true

        $FlyingSpeedColl = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $FlyingSpeedColl.Add($FlyingSpeedAttr)

        $FlyingSpeedParam = New-Object System.Management.Automation.RuntimeDefinedParameter('FlyingSpeed', [int], $FlyingSpeedColl)
        $DynamicParams.Add('FlyingSpeed', $FlyingSpeedParam)
    }

    return $DynamicParams
}