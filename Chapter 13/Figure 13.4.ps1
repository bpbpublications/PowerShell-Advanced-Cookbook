# Create credentials
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

# Create CimSession
$CimSession = New-CimSession -ComputerName "DSCHOST02" -Credential $Credentials

# Get LCM settings
Get-DscLocalConfigurationManager -CimSession $CimSession