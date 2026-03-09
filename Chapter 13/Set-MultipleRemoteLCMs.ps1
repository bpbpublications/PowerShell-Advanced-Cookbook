# Recipe: Configure LCM for Multiple Remote Nodes
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates configuring identical LCM settings
# across multiple remote nodes using a parameterized configuration.
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module, WinRM configured on targets

# ============================================================================
# DEFINE PARAMETERIZED META CONFIGURATION
# ============================================================================

# Create a configuration with a ComputerName parameter
# This generates identical LCM settings for all specified nodes
configuration LCMConfig {
    param
    (
        # Accept an array of computer names
        [string[]]$ComputerName = "localhost"
    )

    # The Node block generates a .meta.mof for each computer name
    Node $ComputerName {
        LocalConfigurationManager {
            # Apply configuration and automatically correct drift
            ConfigurationMode = "ApplyAndAutoCorrect"

            # Check for configuration drift every 30 minutes
            ConfigurationModeFrequencyMins = 30

            # Allow automatic reboot if a resource requires it
            RebootNodeIfNeeded = $true
        }
    }
}

# ============================================================================
# DEFINE TARGET NODES
# ============================================================================

# List of all target nodes to configure
$TargetNodes = @("DSCHOST01", "DSCHOST02", "DSCHOST03", "DSCHOST04")

# ============================================================================
# COMPILE META CONFIGURATION FOR ALL NODES
# ============================================================================

# Compile the configuration for all target nodes at once
# This generates a .meta.mof file for each node
LCMConfig -ComputerName $TargetNodes -OutputPath "C:\DSC\Configs"

# Expected Output:
#     Directory: C:\DSC\Configs
# Mode                LastWriteTime         Length Name
# ----                -------------         ------ ----
# -a----        1/1/2024   10:00 AM           1186 DSCHOST01.meta.mof
# -a----        1/1/2024   10:00 AM           1186 DSCHOST02.meta.mof
# -a----        1/1/2024   10:00 AM           1186 DSCHOST03.meta.mof
# -a----        1/1/2024   10:00 AM           1186 DSCHOST04.meta.mof

# ============================================================================
# CREATE CREDENTIALS AND APPLY LCM SETTINGS
# ============================================================================

# Create credentials for remote connection
# NOTE: This assumes all nodes accept the same credentials
# In production, you might need different credentials per node
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)

# Apply the LCM configurations to all nodes
# Set-DscLocalConfigurationManager reads all .meta.mof files from the path
# and applies each to its corresponding node
Set-DscLocalConfigurationManager -Path "C:\DSC\Configs" -Credential $Credentials -Verbose

# Expected Output:
# VERBOSE: Performing the operation "Start-DscConfiguration: SendMetaConfigurationApply"
#          on target "DSCHOST01".
# VERBOSE: Performing the operation "Start-DscConfiguration: SendMetaConfigurationApply"
#          on target "DSCHOST02".
# VERBOSE: Performing the operation "Start-DscConfiguration: SendMetaConfigurationApply"
#          on target "DSCHOST03".
# VERBOSE: Performing the operation "Start-DscConfiguration: SendMetaConfigurationApply"
#          on target "DSCHOST04".
#
# NOTE: All nodes now have identical LCM settings
# Use hashtable-based configuration (Set-HashtableLCMs.ps1) for unique per-node settings

