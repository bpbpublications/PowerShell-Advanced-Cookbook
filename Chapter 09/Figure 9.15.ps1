# Figure 9.15 - View User's Group Memberships
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates viewing all groups a user or group belongs to.

# ============================================================================
# VIEW USER'S GROUP MEMBERSHIPS
# ============================================================================

# Get all groups that the user "meh" is a member of
Get-ADPrincipalGroupMembership -Identity meh | Select-Object Name

# Expected Output:
# Name
# ----
# Domain Users
# TestServerAccess
# ...

# ============================================================================
# USAGE NOTES
# ============================================================================

# - Get-ADPrincipalGroupMembership works for both users and groups
# - Shows direct memberships only (not nested group memberships)
# - Useful for auditing user access and permissions
# - Returns group objects, pipe to Select-Object for specific properties
