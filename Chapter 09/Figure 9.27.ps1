# Update the Company property for all users
Get-ADUser -Filter * `
-Properties Company | `
Set-ADUser -Company "MoppleIT"

# List all current AD users and their company property
Get-ADUser -Filter * `
-Properties Company | `
Select-Object Name,Company