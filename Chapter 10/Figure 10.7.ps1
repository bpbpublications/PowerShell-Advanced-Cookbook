# Figure 10.7 - Create Azure Virtual Machine
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates creating a Windows Server VM using Azure CLI.

# ============================================================================
# CREATE VIRTUAL MACHINE
# ============================================================================

# Create a Windows Server 2022 virtual machine
az vm create `
    --resource-group "TestVM" `
    --name "TestVM" `
    --image "Win2022Datacenter" `
    --size "Standard_B2s" `
    --admin-username "TestUser" `
    --admin-password "@Test123456789" `
    --location "westeurope"

# Expected Output:
# {
#   "fqdns": "",
#   "id": "/subscriptions/.../resourceGroups/TestVM/providers/.../virtualMachines/TestVM",
#   "powerState": "VM running",
#   "privateIpAddress": "10.0.0.4",
#   "publicIpAddress": "20.xxx.xxx.xxx",
#   ...
# }

# ============================================================================
# VM CREATION NOTES
# ============================================================================

# This command automatically creates:
# - Virtual Network (VNet)
# - Network Security Group (NSG)
# - Public IP Address
# - Network Interface (NIC)
# - OS Disk
