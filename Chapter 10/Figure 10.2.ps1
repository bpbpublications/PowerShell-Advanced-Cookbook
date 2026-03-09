# Figure 10.2 - Check Current Azure Account
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates checking the currently logged-in Azure account.

# ============================================================================
# CHECK CURRENT ACCOUNT
# ============================================================================

# Show current account and selected subscription
# Returns an error if not logged in
az account show

# Expected Output (when logged in):
# {
#   "environmentName": "AzureCloud",
#   "id": "subscription-guid-here",
#   "isDefault": true,
#   "name": "My Subscription",
#   "state": "Enabled",
#   "tenantId": "tenant-guid-here",
#   "user": { ... }
# }

# If not logged in, you'll see:
# ERROR: Please run 'az login' to setup account.
