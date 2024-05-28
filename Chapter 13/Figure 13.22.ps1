#Output from running the Get-DscConfiguration and Get-DscConfigurationStatus cmdlets after a failed configuration application

# Specify credentials for CimSession
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

# Create CimSession
$Session = New-CimSession -ComputerName DSCHOST01 -Credential $Credentials

# Get current DSC configuration of target node
Get-DscConfiguration -CimSession $Session

# Get current DSC configuration status of target node
Get-DscConfigurationStatus -CimSession $Session