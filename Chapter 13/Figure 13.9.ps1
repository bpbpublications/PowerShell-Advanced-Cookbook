$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

$CimSession = New-CimSession -ComputerName "DSCHOST02" -Credential $Credentials

Get-DscLocalConfigurationManager -CimSession $CimSession


# Using CimSessions to get the settings for the LCM on target nodes
$CimSession = New-CimSession -ComputerName "DSCHOST01" -Credential $Credentials
Get-DscLocalConfigurationManager -CimSession $CimSession |`
Select-Object PsComputerName,ConfigurationMode,`
ConfigurationModeFrequencyMins,RebootNodeIfNeeded

$CimSession = New-CimSession -ComputerName "DSCHOST02" -Credential $Credentials
Get-DscLocalConfigurationManager -CimSession $CimSession |`
Select-Object PsComputerName,ConfigurationMode,`
ConfigurationModeFrequencyMins,RebootNodeIfNeeded