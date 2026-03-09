# Recipe: Automated Storage Account Creation with Service Principal
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates automated resource creation using service principal authentication.

# ============================================================================
# LOGIN WITH SERVICE PRINCIPAL
# ============================================================================

# Login to Azure using Service Principal credentials
# NOTE: In production, use environment variables or Key Vault for credentials
az login --service-principal `
    --username "7e78e975-3d6e-45ca-8d9a-4614087ae284" `
    --password="-aT8Q~pe6f9Jz_q3V-wK7uVWV.eVISIh5aVJFcjL" `
    --tenant "57f387c6-3587-4ae7-a156-c9c7d10d7df6"

# ============================================================================
# CREATE STORAGE ACCOUNT
# ============================================================================

# Create a storage account in the resource group
# The service principal must have Contributor access to this resource group
az storage account create `
    --name "strginfrastructure" `
    --resource-group "RG-Infrastructure" `
    --location "westeurope" `
    --sku "Standard_LRS" `
    --access-tier "Cool"

# ============================================================================
# LOGOUT
# ============================================================================

# Always logout when done to clear credentials from the session
az logout

# ============================================================================
# VERIFICATION (RUN SEPARATELY)
# ============================================================================

# Verify that the storage account was created
# Run this after logging in with a user account
# az storage account list `
#     --resource-group "RG-Infrastructure" | `
#     ConvertFrom-Json | `
#     Select-Object Name, ResourceGroup
