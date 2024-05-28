# Bulk add users to group

# Filter groups
$Group = Get-ADGroup `
-Filter "Name -eq 'Employees' -and Description -eq 'DK'"

# User foreach-object to add to group
Get-ADUser `
-Filter "Country -eq 'DK' -and Title -eq 'Employee'" | `
ForEach-Object {
    Add-ADGroupMember -Identity $Group -Members $_
}

##########################################################

# Filter groups
$Group = Get-ADGroup `
-Filter "Name -eq 'Employees' -and Description -eq 'DK'"

# Filter users
$Users = Get-ADUser `
-Filter "Country -eq 'DK' -and Title -eq 'Employee'"

# Add filtered users to filtered group
Add-ADGroupMember -Identity $Group -Members $Users

# Verify added users to group
Get-ADGroup `
-Filter "Name -eq 'Employees' -and Description -eq 'DK'" `
-Properties Members
