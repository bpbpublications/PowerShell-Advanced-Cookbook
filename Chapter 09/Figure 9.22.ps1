# Query AD Groups with a specific Description property
Get-ADGroup -Filter "Description -eq 'GB'" `
-Properties Description | `
Select-Object Name,Description
