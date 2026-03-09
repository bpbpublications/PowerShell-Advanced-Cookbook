# Figure 14.23 - Get Firewall Rule
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (NetSecurity module)
# Prerequisites: None (built-in module)

# ============================================================================
# GET A SPECIFIC FIREWALL RULE
# ============================================================================

# Get-NetFirewallRule retrieves firewall rules by display name
# This is useful for checking if a specific rule exists and its configuration
Get-NetFirewallRule -DisplayName RabbitMQ

# Expected Output:
# Name                  : {12345678-1234-1234-1234-123456789012}
# DisplayName           : RabbitMQ
# Description           : Allow inbound connections to RabbitMQ
# DisplayGroup          :
# Group                 :
# Enabled               : True
# Profile               : Any
# Platform              : {}
# Direction             : Inbound
# Action                : Allow
# EdgeTraversalPolicy   : Block
# LooseSourceMapping    : False
# LocalOnlyMapping      : False
# Owner                 :
# PrimaryStatus         : OK
# Status                : The rule was parsed successfully from the store.
# EnforcementStatus     : NotApplicable
# PolicyStoreSource     : PersistentStore
# PolicyStoreSourceType : Local
#
# NOTE: If the rule doesn't exist, an error is returned
# Use -ErrorAction SilentlyContinue to suppress errors

