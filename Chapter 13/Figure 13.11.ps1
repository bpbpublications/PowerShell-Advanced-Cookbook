# Figure 13.11 - Verify LCM Settings After Changes
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module, LCM configurations applied

# ============================================================================
# CREATE CREDENTIALS FOR REMOTE CONNECTIONS
# ============================================================================

# Create credentials for connecting to remote nodes
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)

# ============================================================================
# VERIFY LCM SETTINGS ON DSCHOST02
# ============================================================================

# First, get full LCM settings from DSCHOST02
$CimSession = New-CimSession -ComputerName "DSCHOST02" -Credential $Credentials
Get-DscLocalConfigurationManager -CimSession $CimSession

# ============================================================================
# COMPARE LCM SETTINGS ACROSS NODES AFTER CONFIGURATION CHANGES
# ============================================================================

# Get key LCM settings from DSCHOST01
$CimSession = New-CimSession -ComputerName "DSCHOST01" -Credential $Credentials
Get-DscLocalConfigurationManager -CimSession $CimSession | `
    Select-Object PSComputerName, ConfigurationMode, `
    ConfigurationModeFrequencyMins, RebootNodeIfNeeded

# Expected Output for DSCHOST01 (after applying node-specific config):
# PSComputerName                : DSCHOST01
# ConfigurationMode             : ApplyAndAutoCorrect
# ConfigurationModeFrequencyMins: 15
# RebootNodeIfNeeded            : True

# Get key LCM settings from DSCHOST02
$CimSession = New-CimSession -ComputerName "DSCHOST02" -Credential $Credentials
Get-DscLocalConfigurationManager -CimSession $CimSession | `
    Select-Object PSComputerName, ConfigurationMode, `
    ConfigurationModeFrequencyMins, RebootNodeIfNeeded

# Expected Output for DSCHOST02 (after applying node-specific config):
# PSComputerName                : DSCHOST02
# ConfigurationMode             : ApplyOnly
# ConfigurationModeFrequencyMins: 60
# RebootNodeIfNeeded            : False
#
# NOTE: This verifies that the hashtable-based configuration (Figure 13.10)
# successfully applied different settings to each node

