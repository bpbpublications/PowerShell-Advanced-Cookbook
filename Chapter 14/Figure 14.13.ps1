# Figure 14.13 - List IP Addresses
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (NetTCPIP module)
# Prerequisites: None (built-in module)

# ============================================================================
# LIST ALL IP ADDRESSES
# ============================================================================

# Get-NetIPAddress lists all IP addresses configured on all interfaces
# This includes both IPv4 and IPv6 addresses
Get-NetIPAddress

# Expected Output (partial):
# IPAddress         : fe80::1234:5678:90ab:cdef%12
# InterfaceIndex    : 12
# InterfaceAlias    : Ethernet
# AddressFamily     : IPv6
# Type              : Unicast
# PrefixLength      : 64
# PrefixOrigin      : WellKnown
# SuffixOrigin      : Link
#
# IPAddress         : 192.168.1.100
# InterfaceIndex    : 12
# InterfaceAlias    : Ethernet
# AddressFamily     : IPv4
# Type              : Unicast
# PrefixLength      : 24
# PrefixOrigin      : Manual
# SuffixOrigin      : Manual
#
# IPAddress         : 127.0.0.1
# InterfaceIndex    : 1
# InterfaceAlias    : Loopback Pseudo-Interface 1
# AddressFamily     : IPv4
# ...
#
# NOTE: Use -AddressFamily IPv4 to filter only IPv4 addresses
# Use -InterfaceAlias "Ethernet" to filter by interface

