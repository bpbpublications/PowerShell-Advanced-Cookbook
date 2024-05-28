# Login to Azure using Service Principal
az login --service-principal `
--username "7e78e975-3d6e-45ca-8d9a-4614087ae284" `
--password="-aT8Q~pe6f9Jz_q3V-wK7uVWV.eVISIh5aVJFcjL" `
--tenant "57f387c6-3587-4ae7-a156-c9c7d10d7df6"

# Create resource in RG-Infrastructure
az storage account create `
--name "strginfrastructure" `
--resource-group "RG-Infrastructure" `
--location "westeurope" `
--sku "Standard_LRS" `
--access-tier "Cool"

# Logout of Azure
az logout

# NOT IN SCRIPT
# Verify that the storage account is created
az storage account list `
--resource-group "RG-Infrastructure" | `
ConvertFrom-Json | `
Select-Object Name,ResourceGRoup