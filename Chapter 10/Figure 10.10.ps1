# Figure 10.10 - List NSG Rules
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates listing Network Security Group rules.

# ============================================================================
# LIST NSG RULES
# ============================================================================

# List all rules in a Network Security Group
az network nsg rule list --nsg-name "TestVMNSG" --resource-group "TestVM"

# Expected Output: JSON array of NSG rules including:
# - Rule name, priority, direction
# - Source/destination address prefixes
# - Source/destination port ranges
# - Protocol and access (Allow/Deny)
