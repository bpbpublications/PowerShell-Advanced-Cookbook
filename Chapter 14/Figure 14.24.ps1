# Figure 14.24 - Get Firewall Rule Details
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (NetSecurity module)
# Prerequisites: None (built-in module)

# ============================================================================
# GET FIREWALL RULE WITH SELECTED PROPERTIES
# ============================================================================

# Get basic firewall rule properties
Get-NetFirewallRule -DisplayName RabbitMQ | `
    Select-Object DisplayName, Enabled, Profile, Direction, Action

# Expected Output:
# DisplayName Enabled Profile Direction Action
# ----------- ------- ------- --------- ------
# RabbitMQ       True Any     Inbound   Allow

# ============================================================================
# GET FIREWALL PORT FILTER
# ============================================================================

# Get the port configuration for the rule
Get-NetFirewallRule -DisplayName RabbitMQ | Get-NetFirewallPortFilter

# Expected Output:
# Protocol      : TCP
# LocalPort     : 5672
# RemotePort    : Any
# IcmpType      : Any
# DynamicTarget : Any

# ============================================================================
# GET FIREWALL ADDRESS FILTER
# ============================================================================

# Get the address configuration for the rule
Get-NetFirewallRule -DisplayName RabbitMQ | Get-NetFirewallAddressFilter

# Expected Output:
# LocalAddress  : Any
# RemoteAddress : Any

# ============================================================================
# GET FIREWALL APPLICATION FILTER
# ============================================================================

# Get the application/program associated with the rule
Get-NetFirewallRule -DisplayName RabbitMQ | Get-NetFirewallApplicationFilter

# Expected Output:
# Program : C:\Program Files\RabbitMQ\erl-xxx\bin\erl.exe
# Package :

