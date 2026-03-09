# Figure 14.16 - Manage DNS Client Settings
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (DnsClient module)
# Prerequisites: Administrator privileges for Set operations

# ============================================================================
# GET DNS SERVER ADDRESSES
# ============================================================================

# Get current DNS server addresses for a specific interface
# -InterfaceAlias: The network adapter name
# -AddressFamily: IPv4 or IPv6
Get-DnsClientServerAddress `
    -InterfaceAlias Ethernet `
    -AddressFamily IPv4

# Expected Output:
# InterfaceAlias               Interface Address ServerAddresses
#                              Index     Family
# --------------               --------- ------- ---------------
# Ethernet                            12 IPv4    {192.168.1.10, 192.168.1.11}

# ============================================================================
# SET DNS SERVER ADDRESSES
# ============================================================================

# Configure DNS servers for a specific interface
# NOTE: Requires Administrator privileges
# This example sets Google's public DNS servers
Set-DnsClientServerAddress `
    -InterfaceAlias Ethernet `
    -ServerAddresses "8.8.8.8", "8.8.4.4"

# Expected Output:
# (No output on success)
#
# Common Public DNS Servers:
# - Google: 8.8.8.8, 8.8.4.4
# - Cloudflare: 1.1.1.1, 1.0.0.1
# - OpenDNS: 208.67.222.222, 208.67.220.220
# - Quad9: 9.9.9.9, 149.112.112.112
#
# To reset to DHCP-assigned DNS:
# Set-DnsClientServerAddress -InterfaceAlias Ethernet -ResetServerAddresses

