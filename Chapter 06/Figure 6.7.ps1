# Creating a new remote session to host: PS-HOST01
$Session = New-PSSession -ComputerName "PS-Host01" `
-Credential (Get-Credential)`
-Name "Host01"

# Use session to invoke command on remote host.
Invoke-Command -Session $Session -ScriptBlock {$Env:COMPUTERNAME}

# Use session to invoke another command on remote host.
Invoke-Command -Session $Session -ScriptBlock {(Get-ComputerInfo).OsName}

# Use session to invoke script on remote host
Invoke-Command -Session $Session `
-FilePath C:\Temp\GetComputerName.ps1 `
-ArgumentList "$($Env:COMPUTERNAME)"


# The script GetComputerName.ps1 content:
# [CmdletBinding()]
# param (
#     [String]$ClientHostName
# )

# Write-Output "This script is run on $($Env:COMPUTERNAME) from $ClientHostName"
