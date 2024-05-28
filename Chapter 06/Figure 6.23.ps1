# Create session using credentials
$Session = New-PSSession -ComputerName "PS-HOST01" -Credential (Get-Credential)