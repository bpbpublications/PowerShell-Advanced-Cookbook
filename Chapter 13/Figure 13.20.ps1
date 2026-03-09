# Figure 13.20 - DSC Configuration Folder Structure
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: DSC configuration applied to target node

# ============================================================================
# DSC CONFIGURATION STORAGE LOCATION
# ============================================================================

# This figure shows the contents of the DSC configuration folder on a target node
# Location: C:\Windows\System32\Configuration
#
# This folder contains important DSC files managed by the LCM:
#
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ C:\Windows\System32\Configuration                                        │
# ├─────────────────────────────────────────────────────────────────────────┤
# │ Name                              Description                            │
# ├─────────────────────────────────────────────────────────────────────────┤
# │ Current.mof                       Currently applied configuration        │
# │ Pending.mof                       Configuration waiting to be applied   │
# │ Previous.mof                      Previously applied configuration       │
# │ backup.mof                        Backup of last known good config       │
# │ MetaConfig.mof                    LCM settings for this node             │
# │ DSCStatusHistory.mof              History of configuration runs          │
# │ DSCEngineCache.mof                Cached DSC engine data                 │
# │ BuiltinResourceState\             State data for built-in resources      │
# │ ConfigurationStatus\              Status log files                       │
# └─────────────────────────────────────────────────────────────────────────┘
#
# Key Files:
# - Current.mof: The MOF file currently being enforced by the LCM
# - Pending.mof: A new configuration waiting to be applied (after reboot)
# - Previous.mof: The last successfully applied configuration
# - MetaConfig.mof: Contains LCM settings (mode, frequency, etc.)
#
# NOTE: These files are managed by DSC and should not be manually edited
# Use Remove-DscConfigurationDocument to safely remove configurations

