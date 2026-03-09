# Figure 10.5 - Create Azure Resource Group
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates creating an Azure resource group.

# ============================================================================
# PREREQUISITES
# ============================================================================

# Always be logged into Azure before running az commands
az login

# If you have multiple subscriptions, select the specific one
az account set --subscription "<Subscription ID>"

# ============================================================================
# CREATE RESOURCE GROUP
# ============================================================================

# Define variables for resource group
$GroupName = "TestVM"
$Location = "westeurope"

# Create the resource group
az group create --name $GroupName --location $Location

# Expected Output:
# {
#   "id": "/subscriptions/.../resourceGroups/TestVM",
#   "location": "westeurope",
#   "name": "TestVM",
#   "properties": { "provisioningState": "Succeeded" },
#   ...
# }
