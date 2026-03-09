# Figure 10.8 - Create Azure Virtual Machine (Continued)
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Shows the complete VM creation command (continued from previous figure).

# ============================================================================
# CREATE VIRTUAL MACHINE (FULL COMMAND)
# ============================================================================

# Create a Windows Server 2022 virtual machine
# This is the same command shown split across terminal lines
az vm create `
    --resource-group "TestVM" `
    --name "TestVM" `
    --image "Win2022Datacenter" `
    --size "Standard_B2s" `
    --admin-username "TestUser" `
    --admin-password "@Test123456789" `
    --location "westeurope"

# ============================================================================
# COMMON VM SIZES
# ============================================================================

# Standard_B1s  - 1 vCPU, 1 GB RAM (burstable, low cost)
# Standard_B2s  - 2 vCPU, 4 GB RAM (burstable, dev/test)
# Standard_D2s_v3 - 2 vCPU, 8 GB RAM (general purpose)
# Standard_D4s_v3 - 4 vCPU, 16 GB RAM (general purpose)
