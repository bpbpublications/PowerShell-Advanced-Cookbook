# Recipe: Configure LCM with Hashtable-Based Node Settings
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates configuring LCM settings for multiple nodes
# using hashtables to define unique settings per node.
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module, WinRM configured on targets

# ============================================================================
# DEFINE PARAMETERIZED META CONFIGURATION
# ============================================================================

# Create a configuration that accepts an object parameter
# This allows each node to have unique LCM settings
configuration LCMConfig {
    param
    (
        # Accept a hashtable/object with node configuration
        [object]$NodeConfig
    )

    # Use the NodeName from the configuration object
    Node $NodeConfig.NodeName {
        LocalConfigurationManager {
            # Pull settings from the configuration object
            ConfigurationMode = $NodeConfig.ConfigurationMode
            ConfigurationModeFrequencyMins = $NodeConfig.ConfigurationModeFrequencyMins
            RebootNodeIfNeeded = $NodeConfig.RebootNodeIfNeeded
        }
    }
}

# ============================================================================
# DEFINE NODE-SPECIFIC SETTINGS AS HASHTABLES
# ============================================================================

# Define each node with its unique LCM settings
# This approach is ideal when different nodes need different configurations
$TargetNodes = @(
    @{
        NodeName                       = "DSCHOST01"
        ConfigurationMode              = "ApplyAndAutoCorrect"  # Auto-fix drift
        ConfigurationModeFrequencyMins = 15                     # Check every 15 min
        RebootNodeIfNeeded             = $true                  # Allow reboots
    },
    @{
        NodeName                       = "DSCHOST02"
        ConfigurationMode              = "ApplyOnly"            # Apply once only
        ConfigurationModeFrequencyMins = 60                     # Check every 60 min
        RebootNodeIfNeeded             = $false                 # Never reboot
    }
)

# ============================================================================
# COMPILE META CONFIGURATION FOR EACH NODE
# ============================================================================

# Loop through each node's configuration and compile
foreach ($NodeConfig in $TargetNodes) {
    LCMConfig -NodeConfig $NodeConfig -OutputPath "C:\DSC\Configs"
}

# Expected Output:
#     Directory: C:\DSC\Configs
# Mode                LastWriteTime         Length Name
# ----                -------------         ------ ----
# -a----        1/1/2024   10:00 AM           1186 DSCHOST01.meta.mof
# -a----        1/1/2024   10:00 AM           1168 DSCHOST02.meta.mof

# ============================================================================
# CREATE CREDENTIALS AND APPLY LCM SETTINGS
# ============================================================================

# Create credentials for remote connection
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)

# Apply the LCM configurations to all nodes in the output path
# Set-DscLocalConfigurationManager automatically applies to nodes
# matching the .meta.mof filenames
Set-DscLocalConfigurationManager -Path "C:\DSC\Configs\" -Credential $Credentials -Verbose

# Expected Output:
# VERBOSE: Performing the operation "Start-DscConfiguration: SendMetaConfigurationApply"
#          on target "DSCHOST01".
# VERBOSE: Performing the operation "Start-DscConfiguration: SendMetaConfigurationApply"
#          on target "DSCHOST02".

