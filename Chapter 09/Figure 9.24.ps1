# Search within the default Users container
Get-ADUser -Filter * -SearchBase "CN=Users,DC=moppleit,DC=dk" | `
Select-Object Name,SamAccountName,DistinguishedName

# Search within the DK OU.
Get-ADUser -Filter * -SearchBase "OU=DK,OU=ADUsers,DC=moppleit,DC=dk" | `
Select-Object Name,SamAccountName,DistinguishedName
