# Figure 14.25 - Enable and Disable Firewall Rules
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (NetSecurity module)
# Prerequisites: Administrator privileges

# ============================================================================
# CHECK CURRENT RULE STATUS
# ============================================================================

# Get the current state of the firewall rule
Get-NetFirewallRule -DisplayName RabbitMQ | `
    Select-Object DisplayName, Enabled, Profile, Direction, Action

# Expected Output (Enabled):
# DisplayName Enabled Profile Direction Action
# ----------- ------- ------- --------- ------
# RabbitMQ       True Any     Inbound   Allow

# ============================================================================
# DISABLE FIREWALL RULE
# ============================================================================

# Disable the firewall rule (blocks traffic matching the rule)
Disable-NetFirewallRule -DisplayName RabbitMQ

# Verify the rule is now disabled
Get-NetFirewallRule -DisplayName RabbitMQ | `
    Select-Object DisplayName, Enabled, Profile, Direction, Action

# Expected Output (Disabled):
# DisplayName Enabled Profile Direction Action
# ----------- ------- ------- --------- ------
# RabbitMQ      False Any     Inbound   Allow

# ============================================================================
# ENABLE FIREWALL RULE
# ============================================================================

# Re-enable the firewall rule (allows traffic matching the rule)
Enable-NetFirewallRule -DisplayName RabbitMQ

# Expected Output:
# (No output on success)
#
# NOTE: Disabling a rule is different from deleting it
# - Disabled rules remain in configuration but don't process traffic
# - This is useful for temporary troubleshooting
# - Use Remove-NetFirewallRule to permanently delete a rule

