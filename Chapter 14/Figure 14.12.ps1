# Figure 14.12 - Network IP Configuration
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (NetTCPIP module)
# Prerequisites: None (built-in module)

# ============================================================================
# VIEW NETWORK IP CONFIGURATION
# ============================================================================

# Get-NetIPConfiguration shows a summary of network configuration
# This is similar to ipconfig but with more detailed PowerShell objects
Get-NetIPConfiguration

# Expected Output:
# InterfaceAlias       : Ethernet
# InterfaceIndex       : 12
# InterfaceDescription : Intel(R) Ethernet Connection
# NetProfile.Name      : Domain Network
# IPv4Address          : 192.168.1.100
# IPv4DefaultGateway   : 192.168.1.1
# DNSServer            : 192.168.1.10
#
# InterfaceAlias       : Wi-Fi
# InterfaceIndex       : 15
# InterfaceDescription : Intel(R) Wireless-AC 9560
# NetProfile.Name      : Home Network
# IPv4Address          : 192.168.1.101
# IPv4DefaultGateway   : 192.168.1.1
# DNSServer            : 8.8.8.8
#
# Key Information:
# - InterfaceAlias: Friendly name of the adapter
# - IPv4Address: Current IP address
# - IPv4DefaultGateway: Default gateway for routing
# - DNSServer: Configured DNS servers
#
# For detailed configuration, use:
# Get-NetIPConfiguration -Detailed

