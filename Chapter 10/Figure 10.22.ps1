# Create resource group
$RG = az group create `
--name "RG-Infrastructure" `
--location "westeurope" | `
ConvertFrom-Json

# Create a service principal with contributor permissions
# to a resource group
$SP = az ad sp create-for-rbac `
--name "SP-RG-Infrastructure" `
--role "Contributor" `
--scopes "$($RG.id)" | `
ConvertFrom-Json