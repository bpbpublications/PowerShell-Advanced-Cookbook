# Figure 9.14 - Add Group to AD Group (Nested Groups)
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates adding a group as a member of another group.

# ============================================================================
# ADD GROUP AS MEMBER (NESTED GROUPS)
# ============================================================================

# Add the "Domain users" group as a member of TestServerAccess
# This creates a nested group membership
Add-ADGroupMember -Identity TestServerAccess -Members "Domain users"

# ============================================================================
# VERIFY GROUP MEMBERSHIP
# ============================================================================

# List all members of the group (both users and groups)
Get-ADGroupMember -Identity TestServerAccess

# Expected Output:
# distinguishedName : CN=Domain Users,CN=Users,DC=moppleit,DC=dk
# name              : Domain Users
# objectClass       : group      <-- Note: objectClass is 'group'
# ...

# ============================================================================
# NESTED GROUP BENEFITS
# ============================================================================

# - Simplifies permission management
# - All members of "Domain users" inherit TestServerAccess permissions
# - Changes to "Domain users" automatically reflect in permissions
