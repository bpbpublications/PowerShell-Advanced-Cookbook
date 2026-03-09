# Figure 14.14 - Filter IP Addresses
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (NetTCPIP module)
# Prerequisites: None (built-in module)

# ============================================================================
# GET FILTERED IP ADDRESS INFORMATION
# ============================================================================

# Get IPv4 addresses for a specific interface with selected properties
# -InterfaceAlias: Filter by network adapter name
# -AddressFamily: IPv4 or IPv6
Get-NetIPAddress `
    -InterfaceAlias "Ethernet" `
    -AddressFamily IPv4 | `
    Select-Object IPAddress, PrefixLength

# Expected Output:
# IPAddress      PrefixLength
# ---------      ------------
# 192.168.1.100            24
#
# Key Properties:
# - IPAddress: The IP address assigned to the interface
# - PrefixLength: The subnet mask in CIDR notation (24 = 255.255.255.0)
#
# Common PrefixLength values:
# - 8  = 255.0.0.0 (Class A)
# - 16 = 255.255.0.0 (Class B)
# - 24 = 255.255.255.0 (Class C)
# - 32 = 255.255.255.255 (Host route)
#
# NOTE: Interface alias must match exactly (case-insensitive)
# Use Get-NetAdapter to list available interface names

