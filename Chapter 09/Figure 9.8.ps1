# Add a non-parameterized attribute property value
$Add = @{EmployeeType="Manager"}
Set-ADUser -Identity "meh" -Add $Add

# Replace a non-parameterized attribute property value
$Replace = @{Info="Administrator, Developer, DevOps and author"}
Set-ADUser -Identity "meh" -Replace $Replace

# View AD user after modification
Get-ADUser meh -Properties EmployeeType,Info,TelephoneNumber

# Remove a non-parameterized attribute property value
$Remove = @{TelephoneNumber="+4512345678"}
Set-ADUser -Identity "meh" -Remove $Remove

# Clear a non-parameterized attribute property value
$Clear = "EmployeeType"
Set-ADUser -Identity "meh" -Clear $Clear

# View AD user after modification
Get-ADUser meh -Properties EmployeeType,Info,TelephoneNumber