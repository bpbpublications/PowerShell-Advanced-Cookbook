# Figure 14.27 - Remove Firewall Rule
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (NetSecurity module)
# Prerequisites: Administrator privileges

# ============================================================================
# VERIFY RULE EXISTS BEFORE REMOVAL
# ============================================================================

# Check the firewall rule exists and view its current state
Get-NetFirewallRule -DisplayName RabbitMQ | `
    Select-Object DisplayName, Enabled, Profile, Direction, Action

# Expected Output:
# DisplayName Enabled Profile Direction Action
# ----------- ------- ------- --------- ------
# RabbitMQ       True Any     Inbound   Allow

# ============================================================================
# REMOVE THE FIREWALL RULE
# ============================================================================

# Permanently delete the firewall rule
# WARNING: This action cannot be undone
Remove-NetFirewallRule -DisplayName RabbitMQ

# Expected Output:
# (No output on success)

# ============================================================================
# VERIFY RULE REMOVAL
# ============================================================================

# Attempt to retrieve the rule after removal (results in error)
Get-NetFirewallRule -DisplayName RabbitMQ | `
    Select-Object DisplayName, Enabled, Profile, Direction, Action

# Expected Error:
# Get-NetFirewallRule: No MSFT_NetFirewallRule objects found with property
# 'DisplayName' equal to 'RabbitMQ'.
#
# NOTE: To recreate the rule, use New-NetFirewallRule:
# New-NetFirewallRule -DisplayName "RabbitMQ" `
#     -Direction Inbound `
#     -Protocol TCP `
#     -LocalPort 5672 `
#     -Action Allow

