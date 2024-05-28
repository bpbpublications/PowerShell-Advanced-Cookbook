# Creating a new remote session to host: PS-HOST01
$Session = New-PSSession -ComputerName "PS-Host01" `
-Credential (Get-Credential)`
-Name "Host01"

# Enter Session
Enter-PSSession $Session

# Exit Session
Exit-PSSession