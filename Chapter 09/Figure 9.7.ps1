# Update current and add missing attributes
$Params = @{
    EmailAddress = "Moppleit@hotmail.com"
    Description = "
    IT SystemAdministrator and DevOps at Energi Danmark A/S.
    Owner of Bio-Rent.dk
    Author"
    City = "Ryomgaard"
    Country = "DK"
    MobilePhone = "+4512345678"
    SurName = "Hansen"
    DisplayName = "Morten Hansen"
}

Set-ADUSer -Identity "meh"  @Params

# List newly modified AD User
Get-ADUser meh -Properties DisplayName,EmailAddress,Description,City