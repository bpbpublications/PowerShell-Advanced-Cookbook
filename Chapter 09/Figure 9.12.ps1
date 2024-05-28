# Modify AD Group
$Params = @{
    Description = "Test server access group"
    DisplayName = "Test Server Access"
}
Set-ADGroup -Identity TestServerAccess @Params

# Get newly modified AD group
Get-ADGroup -Identity TestServerAccess -Properties Description,DisplayName