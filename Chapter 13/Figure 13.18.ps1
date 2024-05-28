# Returning the current configuration of a target node using Get-DscConfiguration and selecting specific properties using Select-Object

# Specify credentials for CimSession
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

# Create CimSession
$Session = New-CimSession -ComputerName DSCHOST01 -Credential $Credentials

# Get current DSC configuration of target node with selected properties
Get-DscConfiguration -CimSession $Session | `
Select-Object ConfigurationName,ModuleName,ResourceId,Ensure