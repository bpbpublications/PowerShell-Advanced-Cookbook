# Create Pester Configuration

# Use the Filter option to filter specific tags
$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"
$PesterConfig.Filter.Tag = "Windows"

# Multiple tags are valid options
$PesterConfig.Filter.Tag = "Linux", "MacOS"

#$Config.CodeCoverage.Enabled = $true
#$Config.TestResult.Enabled = $true

# Filter by group (Describe block) name
$Groups = @(
    "Linux Tests - Platform independent"
    "Windows Tests - Platform independent"
    "MacOS Tests - Platform independent"
)
$PesterConfig.Filter.FullName = $Groups

# Use wildcard for filtering group (Describe block) names
$PesterConfig.Filter.FullName = "* independent"