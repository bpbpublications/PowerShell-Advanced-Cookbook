# Search within the DK OU using filter and searchbase.
Get-ADUser -Filter "Title -eq 'Helpdesk'" `
-SearchBase "OU=DK,OU=ADUsers,DC=moppleit,DC=dk" `
-Properties Title | `
Select-Object Name,SamAccountName,Title,DistinguishedName