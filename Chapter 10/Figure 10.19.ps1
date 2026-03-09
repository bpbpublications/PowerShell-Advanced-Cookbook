# Figure 10.19 - Delete Azure Resources and Resource Group
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates deleting individual resources and the resource group.

# ============================================================================
# DELETE INDIVIDUAL RESOURCES (OPTIONAL)
# ============================================================================

# These commands are commented out - use if you need granular control
# Otherwise, just delete the entire resource group

# # Delete disk
# az disk delete `
#     --resource-group "TestVM" `
#     --name "TestVM_OsDisk_1_d4110a26c79b45de873a3143055e56db"

# # Delete network interface (NIC)
# az network nic delete `
#     --resource-group "TestVM" `
#     --name "TestVMVMNic"

# # Delete NSG
# az network nsg delete `
#     --resource-group "TestVM" `
#     --name "TestVMNSG"

# # Delete Public IP address
# az network public-ip delete `
#     --resource-group "TestVM" `
#     --name "TestVMPublicIP"

# # Delete virtual network
# az network vnet delete `
#     --resource-group "testVM" `
#     --name "TestVMVNET"

# ============================================================================
# DELETE ENTIRE RESOURCE GROUP (RECOMMENDED)
# ============================================================================

# Delete the resource group and ALL resources within it
az group delete --name "TestVM"

# Will prompt for confirmation

# ============================================================================
# VERIFY DELETION
# ============================================================================

# After deletion completes, this will error (group not found)
az resource list --resource-group "TestVM" --output table
