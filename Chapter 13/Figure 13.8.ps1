# Figure 13.8 - Parameterized LCM Configuration
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module

# ============================================================================
# PARAMETERIZED META CONFIGURATION
# ============================================================================

# This configuration uses parameters to generate LCM settings for multiple nodes
# Using a parameter allows the same configuration to be reused for many nodes
configuration LCMConfig {
    param
    (
        # Accept an array of computer names, defaulting to localhost
        [string[]]$ComputerName = "localhost"
    )

    # The Node block generates a separate .meta.mof for each computer name
    Node $ComputerName {
        LocalConfigurationManager {
            # ApplyAndAutoCorrect: Apply config and fix drift automatically
            ConfigurationMode = "ApplyAndAutoCorrect"

            # Check for configuration drift every 30 minutes
            ConfigurationModeFrequencyMins = 30

            # Allow automatic reboot if a resource requires it
            RebootNodeIfNeeded = $true
        }
    }
}

# ============================================================================
# COMPILE CONFIGURATION FOR MULTIPLE NODES
# ============================================================================

# Define the list of target nodes
$TargetNodes = @("DSCHOST01", "DSCHOST02", "DSCHOST03", "DSCHOST04")

# Compile the configuration for all target nodes at once
# This generates a .meta.mof file for each node in the output path
LCMConfig -ComputerName $TargetNodes -OutputPath "C:\DSC\Configs"

# Expected Output:
#     Directory: C:\DSC\Configs
#
# Mode                LastWriteTime         Length Name
# ----                -------------         ------ ----
# -a----        1/1/2024   10:00 AM           1186 DSCHOST01.meta.mof
# -a----        1/1/2024   10:00 AM           1186 DSCHOST02.meta.mof
# -a----        1/1/2024   10:00 AM           1186 DSCHOST03.meta.mof
# -a----        1/1/2024   10:00 AM           1186 DSCHOST04.meta.mof
#
# NOTE: All nodes get identical LCM settings with this approach
# For node-specific settings, use hashtable-based configuration (Figure 13.10)

