# Figure 13.4 - Get LCM Settings via CIM Session
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module, WinRM configured on target

# ============================================================================
# CREATE CREDENTIALS FOR REMOTE CONNECTION
# ============================================================================

# Create credentials for connecting to the remote node
# NOTE: In production, use Get-Credential or secure credential storage
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)

# ============================================================================
# CREATE CIM SESSION TO REMOTE NODE
# ============================================================================

# CIM sessions are used for remote DSC operations
# They provide a persistent connection to the target node
$CimSession = New-CimSession -ComputerName "DSCHOST02" -Credential $Credentials

# ============================================================================
# GET LOCAL CONFIGURATION MANAGER (LCM) SETTINGS
# ============================================================================

# The LCM is the DSC engine that runs on each target node
# It manages how configurations are applied and maintained
Get-DscLocalConfigurationManager -CimSession $CimSession

# Expected Output:
# ActionAfterReboot              : ContinueConfiguration
# AgentId                        : xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
# AllowModuleOverWrite           : False
# CertificateID                  :
# ConfigurationDownloadManagers  : {}
# ConfigurationID                :
# ConfigurationMode              : ApplyAndMonitor
# ConfigurationModeFrequencyMins : 15
# Credential                     :
# DebugMode                      : {NONE}
# DownloadManagerCustomData      :
# DownloadManagerName            :
# LCMCompatibleVersions          : {1.0, 2.0}
# LCMState                       : Idle
# LCMStateDetail                 :
# LCMVersion                     : 2.0
# StatusRetentionTimeInDays      : 10
# PartialConfigurations          :
# RebootNodeIfNeeded             : False
# RefreshFrequencyMins           : 30
# RefreshMode                    : PUSH
# ReportManagers                 : {}
# ResourceModuleManagers         : {}
# PSComputerName                 : DSCHOST02

