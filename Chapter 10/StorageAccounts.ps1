# Recipe: Azure Storage Account Operations
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates complete storage account lifecycle management.

# ============================================================================
# CREATE RESOURCE GROUP
# ============================================================================

# Create a new resource group for storage
$Group = az group create `
    --name "RG-Storage" `
    --location westeurope

# Extract the group name from the returned JSON
$GroupName = $Group | ConvertFrom-Json | Select-Object -ExpandProperty Name

# ============================================================================
# CREATE STORAGE ACCOUNT
# ============================================================================

# Create a storage account with specific settings
az storage account create `
    --name "moppleitstorage" `
    --resource-group $GroupName `
    --location "westeurope" `
    --sku "Standard_LRS" `
    --access-tier "Hot"

# ============================================================================
# LIST STORAGE ACCOUNTS
# ============================================================================

# List all storage accounts in the subscription
az storage account list

# List storage accounts in specific resource group
az storage account list --resource-group $GroupName

# List with table output format
az storage account list `
    --resource-group $GroupName `
    --output table

# List with PowerShell filtering
az storage account list `
    --resource-group $GroupName | `
    ConvertFrom-Json | `
    Select-Object Name, Location, Sku, Kind, AccessTier

# ============================================================================
# UPDATE STORAGE ACCOUNT
# ============================================================================

# Update storage account settings
az storage account update `
    --name "moppleitstorage" `
    --resource-group $GroupName `
    --access-tier "Cool" `
    --min-tls-version "TLS1_2"

# ============================================================================
# GET CONNECTION STRING AND KEYS
# ============================================================================

# Retrieve the connection string (for app configuration)
az storage account show-connection-string `
    --name "moppleitstorage" `
    --resource-group $GroupName

# Retrieve storage account keys
az storage account keys list `
    --account-name "moppleitstorage" `
    --resource-group $GroupName

# ============================================================================
# DELETE STORAGE ACCOUNT
# ============================================================================

# Delete the storage account
az storage account delete `
    --name "moppleitstorage" `
    --resource-group $GroupName `
    --yes
