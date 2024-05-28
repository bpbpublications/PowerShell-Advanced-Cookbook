# Query AD users in a specific country
Get-ADuser -Filter "Country -eq 'DK'" `
-Properties Country,Title | `
Select-Object Name,SamAccountName,Country,Title
