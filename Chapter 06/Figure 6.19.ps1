# Retrieve a credential object and assign the password property to a variable
$Credential = Get-StoredCredential -Target ApiKey
$ApiKey = [System.Net.NetworkCredential]::new("", $Credential.Password).Password
$ApiKey