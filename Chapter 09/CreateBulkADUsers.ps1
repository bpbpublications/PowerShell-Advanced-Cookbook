[CmdletBinding()]
param (
    [Parameter(Mandatory=$true,Position=0)]
    [String]$CsvFilePath
)

$ErrorActionPreference = "Stop"

function Main {
    $CsvContent = Import-Csv $CsvFilePath -Delimiter ";"

    foreach ($User in $CsvContent){
        $Params = @{
            GivenName = $User.GivenName
            SurName = $User.SurName
            JobTitle = $User.JobTitle
            Department = $User.Department
            Country = $User.Country
            MobilePhone = $User.MobilePhone
        }

        try{
            .\CreateADUser.ps1 @Params
            Write-Verbose "Created user for: $($User.GivenName) $($User.SurName)"
        }
        catch{
            Write-Output "Could not create user: $($User.GivenName) $($User.SurName)"
            $_
        }
    }

}

Main