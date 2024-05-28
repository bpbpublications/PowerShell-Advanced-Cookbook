# Create a Pester configuration
$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

# View the type
$PesterConfig.GetType()

# View the Pester Configuration
$PesterConfig