# Import encrypted XML file content
$Credential = Import-CliXml -Path C:\Temp\Encrypted.xml
$Credential
#New-PSSession -ComputerName "PS-HOST01" -Credential $Credential

# Assign password property from imported credential object to variable
$ConnString = [System.Net.NetworkCredential]::new("", $Credential.Password).Password
$ConnString