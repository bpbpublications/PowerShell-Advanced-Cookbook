# Figure 10.1 - Verify Azure CLI Installation
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates checking the Azure CLI version.

# ============================================================================
# CHECK AZURE CLI VERSION
# ============================================================================

# Show Azure CLI version - also used to verify installation
# If az is not installed, this will error
az version

# Expected Output:
# {
#   "azure-cli": "2.53.0",
#   "azure-cli-core": "2.53.0",
#   "azure-cli-telemetry": "1.1.0",
#   ...
# }

# ============================================================================
# INSTALLATION
# ============================================================================

# Windows:   winget install Microsoft.AzureCLI
# macOS:     brew install azure-cli
# Linux:     curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
