# Using the Get-DscConfigurationStatus cmdlet to get the status for the last applied configuration on a target node

# Specify credentials for CimSession
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

# Create CimSession
$Session = New-CimSession -ComputerName DSCHOST01 -Credential $Credentials

# Get current DSC configuration of target node with selected properties
Get-DscConfigurationStatus -CimSession $Session