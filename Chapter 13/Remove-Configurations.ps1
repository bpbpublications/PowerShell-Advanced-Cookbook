# Create the credentials
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

# Create a CimSession 
$Session = New-CimSession -ComputerName "DSCHOST01" -Credential $Credentials

# Get the DSC configuration status from the target node
#Get-DscConfigurationStatus -CimSession $Session

Remove-DscConfigurationDocument -CimSession $Session `
-Stage Current,Pending,Previous -Force