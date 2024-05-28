# Delete AD Group
Remove-ADGroup -Identity TestServerAccess

# Delete AD Group
Remove-ADGroup -Identity TestServerAccess -Confirm:$false

# Get members of an AD Group
Get-ADGroupMember -Identity TestServerAccess