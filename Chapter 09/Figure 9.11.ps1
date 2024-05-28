# Create a new AD Group
$Params = @{
    Name = "TestServerAccess"
    DisplayName = "TestServerAccess"
    GroupScope = "Global"
    Path = "OU=Custom,OU=ADGroups,DC=moppleit,DC=dk"
    Description = "Grants access to all test servers"
}
New-ADGroup @Params

# Get newly created AD group
Get-ADGroup -Identity TestServerAccess -Properties Description,DisplayName