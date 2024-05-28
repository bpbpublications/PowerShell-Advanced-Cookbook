# Requires either Windows Server with Active Directory Domain services installed 
# or Win 10/11 and Remote Server Administration Tool (RSAT) installed.

# Import the ActiveDirectory module
Import-Module ActiveDirectory

# Check that module is imported
Get-Module ActiveDirectory

# Get all ActiveDirectory module commands
Get-Command -Module ActiveDirectory