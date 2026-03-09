# Figure 13.9 - Get LCM Settings for Multiple Nodes
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module, WinRM configured on targets

# ============================================================================
# CREATE CREDENTIALS FOR REMOTE CONNECTIONS
# ============================================================================

# Create credentials for connecting to remote nodes
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)

# ============================================================================
# GET LCM SETTINGS FROM FIRST NODE
# ============================================================================

# Create CIM session to DSCHOST02 and retrieve full LCM settings
$CimSession = New-CimSession -ComputerName "DSCHOST02" -Credential $Credentials
Get-DscLocalConfigurationManager -CimSession $CimSession

# ============================================================================
# GET SPECIFIC LCM SETTINGS FROM MULTIPLE NODES
# ============================================================================

# Get LCM settings from DSCHOST01 with selected properties
$CimSession = New-CimSession -ComputerName "DSCHOST01" -Credential $Credentials
Get-DscLocalConfigurationManager -CimSession $CimSession | `
    Select-Object PSComputerName, ConfigurationMode, `
    ConfigurationModeFrequencyMins, RebootNodeIfNeeded

# Expected Output for DSCHOST01:
# PSComputerName                : DSCHOST01
# ConfigurationMode             : ApplyAndAutoCorrect
# ConfigurationModeFrequencyMins: 15
# RebootNodeIfNeeded            : True

# Get LCM settings from DSCHOST02 with selected properties
$CimSession = New-CimSession -ComputerName "DSCHOST02" -Credential $Credentials
Get-DscLocalConfigurationManager -CimSession $CimSession | `
    Select-Object PSComputerName, ConfigurationMode, `
    ConfigurationModeFrequencyMins, RebootNodeIfNeeded

# Expected Output for DSCHOST02:
# PSComputerName                : DSCHOST02
# ConfigurationMode             : ApplyOnly
# ConfigurationModeFrequencyMins: 60
# RebootNodeIfNeeded            : False
#
# NOTE: Different nodes can have different LCM settings
# This allows flexible configuration management across your environment

