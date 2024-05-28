# List all current AD users and their company property
Get-ADUser -Filter * `
-Properties Company | `
Select-Object Name,Company