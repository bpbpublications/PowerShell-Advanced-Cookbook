# Check for current pester versions
Get-Module -ListAvailable | Where-Object {$_.Name -eq "Pester"}

# Install Pester module
Install-Module Pester -Force

# Import Pester module
Import-Module Pester

# View current imported Pester module
Get-Module Pester