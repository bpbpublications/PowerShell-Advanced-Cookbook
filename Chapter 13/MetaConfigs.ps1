# Recipe: LCM Meta Configurations
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates defining meta configurations for the Local
# Configuration Manager (LCM) on different target nodes with unique settings.
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module

# ============================================================================
# META CONFIGURATION FOR DSCHOST01
# ============================================================================

# Define LCM settings for DSCHOST01
# Meta configurations control how the LCM behaves on the target node
configuration ConfigDSCHOST01 {
    Node "DSCHOST01" {
        LocalConfigurationManager {
            # ApplyAndAutoCorrect: Apply config and automatically fix drift
            ConfigurationMode = "ApplyAndAutoCorrect"

            # Check for drift every 15 minutes
            ConfigurationModeFrequencyMins = 15

            # Allow automatic reboot if required by a resource
            RebootNodeIfNeeded = $true
        }
    }
}

# ============================================================================
# META CONFIGURATION FOR DSCHOST02
# ============================================================================

# Define LCM settings for DSCHOST02 with different settings
configuration ConfigDSCHOST02 {
    Node "DSCHOST02" {
        LocalConfigurationManager {
            # ApplyAndAutoCorrect: Apply config and automatically fix drift
            ConfigurationMode = "ApplyAndAutoCorrect"

            # Check for drift every 20 minutes (different from DSCHOST01)
            ConfigurationModeFrequencyMins = 20

            # Allow automatic reboot if required by a resource
            RebootNodeIfNeeded = $true
        }
    }
}

# ============================================================================
# COMPILE META CONFIGURATIONS (COMMENTED BY DEFAULT)
# ============================================================================

# Uncomment to compile the meta configurations
# This generates .meta.mof files for each node

#ConfigDSCHOST01

# Expected Output:
#     Directory: C:\Users\Administrator\ConfigDSCHOST01
# Mode                LastWriteTime         Length Name
# ----                -------------         ------ ----
# -a----        1/1/2024   10:00 AM           1186 DSCHOST01.meta.mof

#ConfigDSCHOST02

# Expected Output:
#     Directory: C:\Users\Administrator\ConfigDSCHOST02
# Mode                LastWriteTime         Length Name
# ----                -------------         ------ ----
# -a----        1/1/2024   10:00 AM           1168 DSCHOST02.meta.mof
#
# NOTE: After compiling, apply with Set-DscLocalConfigurationManager:
# Set-DscLocalConfigurationManager -Path .\ConfigDSCHOST01 -CimSession $Session

