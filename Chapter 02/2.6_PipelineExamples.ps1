function Add-ValueFromPipeline {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [PSObject]$Obj
    )

    process{
        Write-Output "$($Obj.Name) is $($Obj.Age) years old"
    }
}

function Add-ValueFromPipelineByPropertyName {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [String]$Name,
        [Parameter(ValueFromPipelineByPropertyName)]
        [Int]$Age
    )

    process{
        Write-Output "$($Name) is $($Age) years old"
    }
}

$Data = @(
    [PSCustomObject]@{Name="Comet";Age=43},
    [PSCustomObject]@{Name="Blue Ghost";Age=207},
    [PSCustomObject]@{Name="Evilin";Age=33}
) 

$Data |Add-ValueFromPipelineByPropertyName

