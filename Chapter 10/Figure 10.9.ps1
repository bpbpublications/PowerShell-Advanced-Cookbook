# Figure 10.9 - List Resources in Resource Group
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates listing resources with different output formats.

# ============================================================================
# LIST RESOURCES - TABLE OUTPUT
# ============================================================================

# Using Azure CLI's built-in table output format
az resource list --resource-group "TestVM" --output table

# ============================================================================
# LIST RESOURCES - POWERSHELL FILTERING
# ============================================================================

# Using ConvertFrom-Json for PowerShell-style filtering
az resource list --resource-group "TestVM" | `
    ConvertFrom-Json | `
    Select-Object Name, Type

# Expected Output:
# Name              Type
# ----              ----
# TestVM            Microsoft.Compute/virtualMachines
# TestVMVMNic       Microsoft.Network/networkInterfaces
# TestVMNSG         Microsoft.Network/networkSecurityGroups
# TestVMPublicIP    Microsoft.Network/publicIPAddresses
# TestVMVNET        Microsoft.Network/virtualNetworks
# ...
