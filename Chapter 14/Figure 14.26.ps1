# Figure 14.26 - View Modified Firewall Rule
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (NetSecurity module)
# Prerequisites: None (built-in module)

# ============================================================================
# VIEW FIREWALL RULE AFTER MODIFICATIONS
# ============================================================================

# This example shows retrieving firewall rule information after changes
# Useful for verifying modifications were applied correctly

# Get basic firewall rule properties
Get-NetFirewallRule -DisplayName RabbitMQ | `
    Select-Object DisplayName, Enabled, Profile, Direction, Action

# Expected Output:
# DisplayName Enabled Profile Direction Action
# ----------- ------- ------- --------- ------
# RabbitMQ       True Any     Inbound   Allow

# ============================================================================
# GET PORT CONFIGURATION
# ============================================================================

# Get the port filter to verify port settings
Get-NetFirewallRule -DisplayName RabbitMQ | Get-NetFirewallPortFilter

# Expected Output:
# Protocol      : TCP
# LocalPort     : 5672
# RemotePort    : Any
# IcmpType      : Any
# DynamicTarget : Any

# ============================================================================
# GET ADDRESS CONFIGURATION
# ============================================================================

# Get the address filter to verify IP restrictions
Get-NetFirewallRule -DisplayName RabbitMQ | Get-NetFirewallAddressFilter

# Expected Output:
# LocalAddress  : Any
# RemoteAddress : Any
#
# NOTE: To modify an existing rule, use Set-NetFirewallRule
# Example: Set-NetFirewallRule -DisplayName RabbitMQ -RemoteAddress "192.168.1.0/24"

