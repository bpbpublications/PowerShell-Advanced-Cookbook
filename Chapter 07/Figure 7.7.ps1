# Create a Pester configuration. Save the configuration in a Configuration file
$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

# dot source the configuration file into the current session
# The path must be to the config file!
. ..\PesterConfigs\PesterConfig-Detailed.ps1

# Invoke Pester using the configuration from the configuraition file
Invoke-Pester -Configuration $PesterConfig