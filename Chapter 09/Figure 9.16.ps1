# Figure 9.16 - Remove Members from AD Group
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates removing users or groups from an AD group.

# ============================================================================
# REMOVE MEMBER WITH CONFIRMATION
# ============================================================================

# Remove user from group (will prompt for confirmation)
Remove-ADGroupMember -Identity TestServerAccess -Members meh

# ============================================================================
# REMOVE MEMBER WITHOUT CONFIRMATION
# ============================================================================

# Skip the confirmation prompt with -Confirm:$false
Remove-ADGroupMember -Identity TestServerAccess -Members meh -Confirm:$false

# ============================================================================
# VERIFY MEMBERSHIP REMOVED
# ============================================================================

# List remaining members of the group
Get-ADGroupMember -Identity TestServerAccess

# If no members remain, the output will be empty
