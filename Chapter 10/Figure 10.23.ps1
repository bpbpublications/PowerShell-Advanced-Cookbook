# Figure 10.23 - Login with Service Principal and Create Resources
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates using a service principal for automated resource creation.

# ============================================================================
# CONTENT OF CreateSAScript.ps1
# ============================================================================

# Login to Azure using Service Principal
az login --service-principal `
    --username "7e78e975-3d6e-45ca-8d9a-4614087ae284" `
    --password="-aT8Q~pe6f9Jz_q3V-wK7uVWV.eVISIh5aVJFcjL" `
    --tenant "57f387c6-3587-4ae7-a156-c9c7d10d7df6"

# Create a storage account in the resource group
az storage account create `
    --name "strginfrastructure" `
    --resource-group "RG-Infrastructure" `
    --location "westeurope" `
    --sku "Standard_LRS" `
    --access-tier "Cool"

# Logout of Azure
az logout

# ============================================================================
# VERIFICATION (NOT IN SCRIPT)
# ============================================================================

# Verify that the storage account was created
az storage account list `
    --resource-group "RG-Infrastructure" | `
    ConvertFrom-Json | `
    Select-Object Name, ResourceGroup

# ============================================================================
# SECURITY NOTES
# ============================================================================

# - Never commit credentials to source control
# - Use Azure Key Vault or environment variables
# - Rotate service principal secrets regularly
# - Use managed identities when possible
