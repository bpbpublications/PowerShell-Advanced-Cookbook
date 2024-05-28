# Create configuration with parameters
configuration LCMConfig {
    param
    (
        [object]$NodeConfig
        
    )

    Node $NodeConfig.NodeName {
        LocalConfigurationManager {
            ConfigurationMode = $NodeConfig.ConfigurationMode
            ConfigurationModeFrequencyMins = $NodeConfig.ConfigurationModeFrequencyMins
            RebootNodeIfNeeded = $NodeConfig.RebootNodeIfNeeded
        }
    }
} 

# List of target nodes with configurations as objects
$TargetNodes = @(
    @{
        NodeName = "DSCHOST01"
        ConfigurationMode = "ApplyAndAutoCorrect"
        ConfigurationModeFrequencyMins = 15
        RebootNodeIfNeeded = $true
    },
    @{
        NodeName = "DSCHOST02"
        ConfigurationMode = "ApplyOnly"
        ConfigurationModeFrequencyMins = 60
        RebootNodeIfNeeded = $false
    }
) 

# Create Configuration for each target node
foreach ($NodeConfig in $TargetNodes) {
    LCMConfig -NodeConfig $NodeConfig -OutputPath "C:\DSC\Configs"
} 
