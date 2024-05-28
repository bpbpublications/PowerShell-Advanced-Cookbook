# Using the -Name parameter to list a specific service
Get-Service -Name WSearch

# The name parameter is positioned at index 0
Get-Service WSearch

# Using the -Name parameter results in an error if a service does not exist
Get-Service WSear