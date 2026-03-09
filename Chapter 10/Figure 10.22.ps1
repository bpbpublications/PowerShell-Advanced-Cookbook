# Figure 10.22 - Create Service Principal with RBAC
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates creating a service principal for automation.

# ============================================================================
# CREATE RESOURCE GROUP
# ============================================================================

# Create a resource group for infrastructure
$RG = az group create `
    --name "RG-Infrastructure" `
    --location "westeurope" | `
    ConvertFrom-Json

# ============================================================================
# CREATE SERVICE PRINCIPAL
# ============================================================================

# Create a service principal with Contributor permissions
# scoped to the resource group
$SP = az ad sp create-for-rbac `
    --name "SP-RG-Infrastructure" `
    --role "Contributor" `
    --scopes "$($RG.id)" | `
    ConvertFrom-Json

# ============================================================================
# OUTPUT CONTAINS CREDENTIALS
# ============================================================================

# The $SP object contains:
# - appId (client ID) - use for --username
# - password (client secret) - use for --password
# - tenant - use for --tenant
#
# IMPORTANT: Save these securely! The password is only shown once.

# Expected Output:
# {
#   "appId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
#   "displayName": "SP-RG-Infrastructure",
#   "password": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
#   "tenant": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
# }
