# Figure 13.7 - Set LCM Settings via CIM Session
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module, compiled meta configuration

# ============================================================================
# CREATE CREDENTIALS FOR REMOTE CONNECTION
# ============================================================================

# Create credentials for connecting to the remote node
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)

# ============================================================================
# CREATE CIM SESSION TO REMOTE NODE
# ============================================================================

# Create a CIM session to the target node for remote DSC operations
$CimSession = New-CimSession -ComputerName "DSCHOST02" -Credential $Credentials

# ============================================================================
# APPLY META CONFIGURATION TO CONFIGURE LCM
# ============================================================================

# Set-DscLocalConfigurationManager applies the meta configuration
# This configures how the LCM behaves on the target node
# -Path: Directory containing the .meta.mof file for the target node
Set-DscLocalConfigurationManager -CimSession $CimSession -Path .\ConfigDSCHOST02

# Expected Output:
# (No output on success - operation completes silently)

# ============================================================================
# VERIFY LCM SETTINGS AFTER CONFIGURATION
# ============================================================================

# Retrieve and verify the LCM settings were applied correctly
# NOTE: This should be Get-DscLocalConfigurationManager, not Set-
Get-DscLocalConfigurationManager -CimSession $CimSession

# Expected Output (showing changed settings):
# ConfigurationMode              : ApplyAndAutoCorrect
# ConfigurationModeFrequencyMins : 20
# RebootNodeIfNeeded             : True
# RefreshMode                    : PUSH
# LCMState                       : Idle
# PSComputerName                 : DSCHOST02

