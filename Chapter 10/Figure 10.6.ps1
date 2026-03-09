# Figure 10.6 - Convert Azure CLI JSON Output
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates converting az CLI JSON output to PowerShell objects.

# ============================================================================
# CONVERT AND FILTER AZ OUTPUT
# ============================================================================

# Azure CLI outputs JSON by default
# Use ConvertFrom-Json to create PowerShell objects for easy filtering
az group list | ConvertFrom-Json | Select-Object Name, Location, Properties

# Expected Output:
# Name      Location    Properties
# ----      --------    ----------
# TestVM    westeurope  @{provisioningState=Succeeded}
# ...

# ============================================================================
# BENEFIT OF CONVERSION
# ============================================================================

# Converting to PowerShell objects enables:
# - Select-Object for column selection
# - Where-Object for filtering
# - Sort-Object for ordering
# - Export-Csv for reporting
