# Figure 10.12 - Update NSG Rule with Your IP
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates updating an NSG rule to allow access from your IP.

# ============================================================================
# GET YOUR PUBLIC IP
# ============================================================================

# Retrieve your public IP address
$MyIp1 = (Invoke-RestMethod "http://httpbin.org/ip").origin
$MyIp1

# ============================================================================
# UPDATE NSG RULE
# ============================================================================

# Update the RDP rule to only allow connections from your IP
az network nsg rule update `
    --resource-group "TestVM" `
    --nsg-name "TestVMNSG" `
    --name "rdp" `
    --source-address-prefix $MyIp1

# This restricts RDP access to only your current IP address
# Much more secure than allowing 0.0.0.0/0 (any IP)
