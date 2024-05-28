# Create a new AD user using splatting
$Params = @{
    Name = "Morten E. Hansen"
    GivenName = "Morten"
    SurName = "E. Hansen"
    DisplayName = "Morten E. Hansen"
    SamAccountName = "meh" # Max 20 characters
    UserPrincipalName = "meh@moppleit.dk"
    Path = "OU=DK,OU=ADUsers,DC=moppleit,DC=dk"
    AccountPassword = (ConvertTo-SecureString "Pa$$w0rd" -AsPlainText -Force)
    Enabled = $true
    OtherAttributes = @{
        Info = "Administrator, Developer and DevOps"
        TelephoneNumber = "+4512345678"
    }
}

New-ADUser @Params

# List newly created AD User
Get-ADUser meh -Properties Info,TelephoneNumber,DisplayName