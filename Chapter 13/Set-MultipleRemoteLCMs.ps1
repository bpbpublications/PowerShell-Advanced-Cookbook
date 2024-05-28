
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

# Apply config to each target node (Assumes they have the same user, serviceaccount or WinRM is set up with certificate)
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

Set-DscLocalConfigurationManager -Path "C:\DSC\Configs" -Credential $Credentials -Verbose
