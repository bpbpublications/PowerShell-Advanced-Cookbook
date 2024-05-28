# Creating a new remote session to host: PS-HOST01
$Session = New-PSSession -ComputerName "PS-Host01" `
-Credential (Get-Credential)`
-Name "Host01"

# Get all current sessions on client computer
Get-PSSession