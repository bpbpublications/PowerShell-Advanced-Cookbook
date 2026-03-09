# Figure 10.3 - Login to Azure with Azure CLI
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates interactive Azure CLI login.

# ============================================================================
# INTERACTIVE LOGIN
# ============================================================================

# Login to Azure using Azure CLI
az login

# This will open a browser window for authentication
# After successful login, it returns a list of available subscriptions

# ============================================================================
# OTHER LOGIN METHODS
# ============================================================================

# Device code login (for headless systems):
# az login --use-device-code

# Service principal login (for automation):
# az login --service-principal -u <app-id> -p <password> --tenant <tenant-id>
