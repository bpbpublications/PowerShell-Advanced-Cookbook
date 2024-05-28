# This shows configuration information from target node

# Specify credentials for CimSession
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

# Create CimSession
$Session = New-CimSession -ComputerName DSCHOST01 -Credential $Credentials

# Get current DSC configuration of target node
Get-DscConfiguration -CimSession $Session 
