# Parameterized configurations

# Create configuration with parameters
configuration LCMConfig {
    param
    (
        [string[]]$ComputerName="localhost"
    )

    Node $ComputerName {
        LocalConfigurationManager {
            ConfigurationMode = "ApplyAndAutoCorrect"
            ConfigurationModeFrequencyMins = 30
            RebootNodeIfNeeded = $true
        }
    }
}

# List of target nodes
$TargetNodes = @("DSCHOST01","DSCHOST02","DSCHOST03","DSCHOST04")

# Create Configuration for each target node
LCMConfig -ComputerName $TargetNodes -OutputPath "C:\DSC\Configs" 
