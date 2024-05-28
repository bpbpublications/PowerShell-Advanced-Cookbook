# Create a new script with tests fixture
# Requires Pester 5.5.0
New-Fixture -Name MyScript

# Get content of main script
Get-Content MyScript.ps1

# Get content of test script
Get-Content MyScript.Tests.ps1