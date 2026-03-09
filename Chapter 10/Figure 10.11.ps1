# Figure 10.11 - Get Public IP Address
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates retrieving your public IP address using different methods.

# ============================================================================
# METHOD 1: POWERSHELL INVOKE-RESTMETHOD
# ============================================================================

# Using PowerShell's Invoke-RestMethod cmdlet
$MyIp1 = (Invoke-RestMethod "http://httpbin.org/ip").origin
$MyIp1

# ============================================================================
# METHOD 2: AZURE CLI AZ REST
# ============================================================================

# Using Azure CLI's az rest command with JMESPath query
$MyIp2 = az rest --method get --uri "http://httpbin.org/ip" --query "origin" --output tsv
$MyIp2

# Expected Output:
# 123.45.67.89  (your public IP address)

# ============================================================================
# USE CASE
# ============================================================================

# Knowing your public IP is essential for:
# - Configuring NSG rules to allow access from your location
# - Setting up firewall whitelisting
# - Troubleshooting connectivity issues
