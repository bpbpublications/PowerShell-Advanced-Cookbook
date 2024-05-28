# Query AD users in a specific country with a specific job title
Get-ADuser -Filter "Country -eq 'DK' -and Title -eq 'Employee'" `
-Properties Country,Title | `
Select-Object Name,SamAccountName,Country,Title
