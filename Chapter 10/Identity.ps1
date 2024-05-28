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

# Login to Azure using service principal
az login --service-principal `
--username <APP_ID> `
--password <CLIENT_SECRET/SP_PASSWORD> `
--tenant <TENANT_ID>

# Login to Azure using service principal (Special)
az login --service-principal `
--username <APP_ID> `
--password=<CLIENT_SECRET/SP_PASSWORD> `
--tenant <TENANT_ID>

