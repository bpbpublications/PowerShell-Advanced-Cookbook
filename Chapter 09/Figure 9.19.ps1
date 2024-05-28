# Query all AD users. Selecting specific properties
Get-ADUser -Filter * `
-Properties Country,Title | `
Select-Object Name,SamAccountName,Country,Title
