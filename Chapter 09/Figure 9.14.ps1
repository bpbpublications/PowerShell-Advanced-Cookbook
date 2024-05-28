# Add AD Group to an AD Group
Add-ADGroupMember -Identity TestServerAccess -Members "Domain users"

# Get members of an AD Group
Get-ADGroupMember -Identity TestServerAccess