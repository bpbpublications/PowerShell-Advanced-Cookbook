# Create credentials
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

# Create CimSession
$CimSession = New-CimSession -ComputerName "DSCHOST02" -Credential $Credentials

# Set LCM settings
Set-DscLocalConfigurationManager -CimSession $CimSession -Path .\ConfigDSCHOST02 

# Get LCM Settings after meta configuration application
Set-DscLocalConfigurationManager -CimSession $CimSession