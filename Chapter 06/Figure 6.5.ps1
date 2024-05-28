# Running script with parameter from client on remote host
Invoke-Command -ComputerName PS-Host01 `
-FilePath C:\Temp\GetComputerName.ps1 `
-ArgumentList "$($Env:COMPUTERNAME)" `
-Credential (Get-Credential)


# The script GetComputerName.ps1 content:
# [CmdletBinding()]
# param (
#     [String]$ClientHostName
# )

# Write-Output "This script is run on $($Env:COMPUTERNAME) from $ClientHostName"
