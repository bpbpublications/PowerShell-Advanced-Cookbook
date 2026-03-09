# Figure 13.5 - Invoke Meta Configuration
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: MetaConfigs.ps1 must exist in current directory

# ============================================================================
# LOAD AND INVOKE META CONFIGURATION
# ============================================================================

# Meta configurations define LCM (Local Configuration Manager) settings
# They control how DSC behaves on target nodes

# Dot-source the MetaConfigs.ps1 file to load the configuration into memory
# This makes the configuration function available in the current session
. .\MetaConfigs.ps1

# Invoke the ConfigDSCHOST02 configuration to compile it
# This generates a .meta.mof file that can be applied to configure the LCM
ConfigDSCHOST02

# Expected Output:
#     Directory: C:\Users\Administrator\ConfigDSCHOST02
#
# Mode                LastWriteTime         Length Name
# ----                -------------         ------ ----
# -a----        1/1/2024   10:00 AM           1168 DSCHOST02.meta.mof
#
# NOTE: The output is a .meta.mof file (not a regular .mof file)
# Meta MOF files are specifically for configuring the LCM, not the node state
#
# To apply this meta configuration to the target node, use:
# Set-DscLocalConfigurationManager -Path .\ConfigDSCHOST02 -CimSession $CimSession

