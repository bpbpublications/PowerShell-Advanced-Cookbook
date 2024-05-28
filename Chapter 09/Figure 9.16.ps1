# Remove user and group from AD Group
Remove-ADGroupMember -Identity TestServerAccess -Members meh

# Remove user and group from AD Group
Remove-ADGroupMember -Identity TestServerAccess -Members meh -Confirm:$false

# Get members of an AD Group
Get-ADGroupMember -Identity TestServerAccess