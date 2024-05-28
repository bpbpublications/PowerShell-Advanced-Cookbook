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

# List of target nodes with configurations as hashtables
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

# Apply config to each target node (Assumes they have the same user, serviceaccount or WinRM is set up with certificate)
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

Set-DscLocalConfigurationManager -Path "C:\DSC\Configs\" -Credential $Credentials -Verbose
