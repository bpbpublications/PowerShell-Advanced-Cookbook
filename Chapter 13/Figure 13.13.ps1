# Shoving different resources on node created from DSC

# View computer name
$env:COMPUTERNAME

# View DSCNODE environment variable
([System.Environment])::GetEnvironmentVariables([System.EnvironmentVariableTarget]::Machine)).DSCNODE

# View DSCNODE registry
Get-ItemProperty -Path "HKLM:\SOFTWARE\DSC" -Name DSCNODE