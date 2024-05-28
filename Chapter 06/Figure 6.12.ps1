# Creating a new remote session to host: PS-HOST01 using SessionConfiguration
$Session = New-PSSession -ComputerName "PS-Host01" `
-Credential (Get-Credential)`
-Name "Host01" `
-ConfigurationName MyEnvConfig

# Invoke command on session with session configuration and view $ENV
Invoke-Command -Session $Session -ScriptBlock {dir env:}