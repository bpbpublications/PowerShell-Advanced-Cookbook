# Add members to an AD Group
Add-ADGroupMembers -Identity TestServerAccess -Members meh

# Get members of an AD Group
Get-ADGroupMember -Identity TestServerAccess
