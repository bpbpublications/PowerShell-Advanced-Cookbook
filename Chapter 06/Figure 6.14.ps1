# Create encrypted XML file
$Credential = Get-Credential
$Credential | Export-Clixml -Path C:\Temp\Encrypted.xml

# Get content of encrypted XML file
Get-Content C:\Temp\Encrypted.xml