# Retrieve all powershell (pwsh) processes running on a system
Get-Process | Where-Object {$_.ProcessName -eq "pwsh"}
Get-Process -Name "pwsh"