# Create a resource group for blobs
$GroupName = az group create `
--name "RG-Blobs" `
--location westeurope | `
ConvertFrom-Json | `
Select-Object -ExpandProperty Name

# Create a storage account for blobs
$StorageName = az storage account create `
--name "moppleitblobs" `
--resource-group $GroupName `
--location "westeurope" `
--sku "Standard_LRS" `
--access-tier "Hot" | `
ConvertFrom-Json | `
Select-Object -ExpandProperty Name

# Retrieve storage account key
$StorageKey = az storage account keys list `
--account-name $StorageName `
--resource-group $GroupName | `
ConvertFrom-Json | `
Select-Object -ExpandProperty value -First 1

# Create a blob container
az storage container create `
--name "blobcontainer" `
--account-name $StorageName `
--account-key $StorageKey

# List blob containers
az storage container list `
--account-name $StorageName `
--account-key $StorageKey

# Upload a file to a blob container
az storage blob upload `
--account-name $StorageName `
--account-key $StorageKey `
--type block `
--file C:\Temp\test.txt `
--container-name "blobcontainer"

# List all blobs in a blob container
az storage blob list `
--account-name $StorageName `
--account-key $StorageKey `
--container-name "blobcontainer"

# Download a file from a blob container
az storage blob download `
--account-name $StorageName `
--account-key $StorageKey `
--container-name "blobcontainer" `
--name "test.txt" `
--file C:\Temp\NewTest.txt

 # Delete a blob (file) in a blob container
 az storage blob delete `
 --account-name $StorageName `
 --account-key $StorageKey `
 --container-name "blobcontainer" `
 --name "test.txt" 

 # Delete a blob container
az storage container delete `
--account-name $StorageName `
--account-key $StorageKey `
--name "blobcontainer"
