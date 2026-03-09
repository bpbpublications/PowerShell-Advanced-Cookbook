# Figure 10.18 - Delete Azure Virtual Machine
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates deleting an Azure VM and verifying deletion.

# ============================================================================
# DELETE VIRTUAL MACHINE
# ============================================================================

# Delete the VM (--yes skips confirmation prompt)
az vm delete `
    --resource-group "TestVM" `
    --name "TestVM" `
    --yes

# ============================================================================
# VERIFY DELETION
# ============================================================================

# List remaining resources in the resource group
# Note: Deleting VM does NOT delete associated resources
az resource list --resource-group "TestVM" --output table

# ============================================================================
# IMPORTANT NOTE
# ============================================================================

# Deleting a VM leaves behind:
# - Disks (OS and data disks)
# - Network interfaces
# - Public IP addresses
# - Network Security Groups
# - Virtual Networks
# These must be deleted separately or delete the entire resource group
