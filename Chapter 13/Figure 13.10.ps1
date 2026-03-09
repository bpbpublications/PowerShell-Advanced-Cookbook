# Figure 13.10 - LCM Configuration with Hashtable Objects
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module

# ============================================================================
# PARAMETERIZED META CONFIGURATION WITH OBJECT INPUT
# ============================================================================

# This configuration accepts an object parameter containing node-specific settings
# This allows each node to have unique LCM configurations
configuration LCMConfig {
    param
    (
        # Accept a hashtable/object with node configuration details
        [object]$NodeConfig
    )

    # Use the NodeName property from the configuration object
    Node $NodeConfig.NodeName {
        LocalConfigurationManager {
            # Each property is pulled from the configuration object
            ConfigurationMode = $NodeConfig.ConfigurationMode
            ConfigurationModeFrequencyMins = $NodeConfig.ConfigurationModeFrequencyMins
            RebootNodeIfNeeded = $NodeConfig.RebootNodeIfNeeded
        }
    }
}

# ============================================================================
# DEFINE NODE-SPECIFIC CONFIGURATIONS
# ============================================================================

# Define each node's settings as a hashtable in an array
# This allows different settings per node
$TargetNodes = @(
    @{
        NodeName = "DSCHOST01"
        ConfigurationMode = "ApplyAndAutoCorrect"  # Auto-fix configuration drift
        ConfigurationModeFrequencyMins = 15         # Check every 15 minutes
        RebootNodeIfNeeded = $true                  # Allow automatic reboots
    },
    @{
        NodeName = "DSCHOST02"
        ConfigurationMode = "ApplyOnly"             # Apply once, don't auto-correct
        ConfigurationModeFrequencyMins = 60         # Check every 60 minutes
        RebootNodeIfNeeded = $false                 # Never reboot automatically
    }
)

# ============================================================================
# COMPILE CONFIGURATION FOR EACH NODE
# ============================================================================

# Loop through each node configuration and compile
foreach ($NodeConfig in $TargetNodes) {
    LCMConfig -NodeConfig $NodeConfig -OutputPath "C:\DSC\Configs"
}

# Expected Output:
#     Directory: C:\DSC\Configs
#
# Mode                LastWriteTime         Length Name
# ----                -------------         ------ ----
# -a----        1/1/2024   10:00 AM           1186 DSCHOST01.meta.mof
# -a----        1/1/2024   10:00 AM           1168 DSCHOST02.meta.mof
#
# NOTE: Each node gets its own unique LCM settings based on the hashtable values

