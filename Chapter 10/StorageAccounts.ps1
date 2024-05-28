# Create a new resource group
$Group = az group create `
--name "RG-Storage" `
--location westeurope

# Assign the group name from the return data to the $GroupName variable
$GroupName = $Group | ConvertFrom-Json | Select-Object -ExpandProperty Name

# Create a storage account
az storage account create `
--name "moppleitstorage" `
--resource-group $GroupName `
--location "westeurope" `
--sku "Standard_LRS" `
--access-tier "Hot"

# List All storage accounts
az storage account list

# List storage accounts in specific resoruce group
az storage account list `
--resource-group $GroupName

# List storage account as table output 
az storage account list `
--resource-group $GroupName `
--output table

# List storage account and specific properties
az storage account list `
--resource-group $GroupName | `
ConvertFrom-Json | `
Select-Object Name,Location,Sku, Kind,AccessTier

# Update an existing storage accounts settings
az storage account update `
--name "moppleitstorage" `
--resource-group $GroupName `
--access-tier "Cool" `
--min-tls-version "TLS1_2"

# Retrieve storage account connection string
az storage account show-connection-string `
--name "moppleitstorage" `
--resource-group $GroupName

# Retrieve storage account keys
az storage account keys list `
--account-name "moppleitstorage" `
--resource-group $GroupName

# Delete a storage account
az storage account delete `
--name "moppleitstorage" `
--resource-group $GroupName `
--yes