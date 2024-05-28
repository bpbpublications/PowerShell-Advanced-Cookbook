# Add specific users to a specific group
# Query the specific group:
Get-ADGroup `
-Filter "Name -eq 'Employees' -and Description -eq 'DK'" `
-Properties Members

# Query the specific users
Get-ADUser `
-Filter "Country -eq 'DK' -and Title -eq 'Employee'" `
-Properties Country,Title | `
Select-Object Name,Country,Title
