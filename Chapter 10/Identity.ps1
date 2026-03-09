# Recipe: Service Principal Creation and Login
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates creating and using a service principal for Azure automation.

# ============================================================================
# CREATE RESOURCE GROUP
# ============================================================================

# Create a resource group for infrastructure resources
$RG = az group create `
    --name "RG-Infrastructure" `
    --location "westeurope" | `
    ConvertFrom-Json

# ============================================================================
# CREATE SERVICE PRINCIPAL
# ============================================================================

# Create a service principal with Contributor permissions to the resource group
# This is ideal for CI/CD pipelines and automation scripts
$SP = az ad sp create-for-rbac `
    --name "SP-RG-Infrastructure" `
    --role "Contributor" `
    --scopes "$($RG.id)" | `
    ConvertFrom-Json

# Output contains appId, password (secret), and tenant
# IMPORTANT: Save these immediately - password is only shown once!

# ============================================================================
# LOGIN WITH SERVICE PRINCIPAL
# ============================================================================

# Standard service principal login
az login --service-principal `
    --username "<APP_ID>" `
    --password "<CLIENT_SECRET/SP_PASSWORD>" `
    --tenant "<TENANT_ID>"

# Alternative syntax (use = for passwords with special characters)
az login --service-principal `
    --username "<APP_ID>" `
    --password="<CLIENT_SECRET/SP_PASSWORD>" `
    --tenant "<TENANT_ID>"

# ============================================================================
# SECURITY BEST PRACTICES
# ============================================================================

# - Store credentials in Azure Key Vault
# - Use environment variables, not hardcoded values
# - Rotate secrets regularly
# - Use managed identities when running in Azure
# - Apply least-privilege principle to role assignments
