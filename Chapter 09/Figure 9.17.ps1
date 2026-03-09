# Figure 9.17 - Delete AD Group
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates deleting an AD group.

# ============================================================================
# DELETE GROUP WITH CONFIRMATION
# ============================================================================

# Delete group (will prompt for confirmation)
Remove-ADGroup -Identity TestServerAccess

# ============================================================================
# DELETE GROUP WITHOUT CONFIRMATION
# ============================================================================

# Skip the confirmation prompt with -Confirm:$false
Remove-ADGroup -Identity TestServerAccess -Confirm:$false

# ============================================================================
# VERIFY DELETION
# ============================================================================

# Attempting to get group members after deletion will error
Get-ADGroupMember -Identity TestServerAccess

# Expected Output:
# Get-ADGroup: Cannot find an object with identity: 'TestServerAccess' ...

# ============================================================================
# NOTE
# ============================================================================

# Deleting a group does NOT delete its members
# Members simply lose that group membership
