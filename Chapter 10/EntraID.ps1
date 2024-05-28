# Create reource group
$RG = az group create `
--name "RG-App01" `
--location "westeurope" | `
ConvertFrom-Json

# Create AD/EntraID group
$AdGroup = az ad group create `
--display-name "AccessTo-RG-App01" `
--mail-nickname "AccessTo-RG-App01" | `
ConvertFrom-Json

# Create 3 new users
$Users = @(
    @{
        name = "Liam Anderson"
        upn = "Lian@bio-rent.dk"
        password = "@Test123456789"
    }
    @{
        name = "Mia Garcia"
        upn = "Miga@bio-rent.dk"
        password = "@Test123456789"
    }
    @{
        name = "Oliver Patel"
        upn = "Olpa@bio-rent.dk"
        password = "@Test123456789"
    }
)

foreach ($User in $Users){
    # Create EntraID user
    $ADUser = az ad user create `
    --display-name "$($User.name)" `
    --user-principal-name "$($User.upn)" `
    --password "$($User.password)" | `
    ConvertFrom-Json

    # Add user to AD/EntraID group
    az ad group member add `
    --group "$($AdGroup.id)" `
    --member-id "$($ADUser.id)"
}

# Assign contributor role for resource group to AD Group
az role assignment create `
--assignee "$($AdGroup.id)" `
--role "Contributor" `
--scope "$($RG.id)"
