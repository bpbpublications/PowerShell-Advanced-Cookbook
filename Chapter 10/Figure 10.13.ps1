# Figure 10.13 - Create NSG Rule for WinRM
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates creating an NSG rule to allow WinRM access.

# ============================================================================
# GET YOUR PUBLIC IP
# ============================================================================

# Retrieve your public IP address
$MyIp1 = (Invoke-RestMethod "http://httpbin.org/ip").origin
$MyIp1

# ============================================================================
# CREATE WINRM NSG RULE
# ============================================================================

# Create NSG rule to allow WinRM (port 5985) from your IP only
az network nsg rule create `
    --resource-group "TestVM" `
    --nsg-name "TestVMNSG" `
    --name "WinRM" `
    --source-address-prefix $MyIp1 `
    --destination-port-range 5985 `
    --priority 1001 `
    --protocol "TCP"

# ============================================================================
# WINRM PORTS
# ============================================================================

# Port 5985 - WinRM HTTP (unencrypted)
# Port 5986 - WinRM HTTPS (encrypted, recommended for production)
