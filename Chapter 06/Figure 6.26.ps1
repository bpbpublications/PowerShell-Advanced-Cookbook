# use certificate bases session within script

### RemoteScript.ps1 Script content ###
# $Session = New-PSSession -ComputerName "PS-HOST01" -UseSSL
# Invoke-Command -Session $Session -ScriptBlock {"I am $($Env:COMPUTERNAME)"}
# Remove-PSSession $Session

Get-Content .\RemoteScript.ps1
.\RemoteScript.ps1