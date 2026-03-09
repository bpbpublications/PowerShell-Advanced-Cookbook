# Figure 9.13 - Add Members to AD Group
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates adding users to an AD group.

# ============================================================================
# ADD USER TO GROUP
# ============================================================================

# Add a single user to a group
Add-ADGroupMember -Identity TestServerAccess -Members meh

# ============================================================================
# VERIFY GROUP MEMBERSHIP
# ============================================================================

# List all members of the group
Get-ADGroupMember -Identity TestServerAccess

# Expected Output:
# distinguishedName : CN=Morten E. Hansen,OU=DK,OU=ADUsers,DC=moppleit,DC=dk
# name              : Morten E. Hansen
# objectClass       : user
# objectGUID        : ...
# SamAccountName    : meh
# SID               : ...

# ============================================================================
# ADD MULTIPLE MEMBERS
# ============================================================================

# You can add multiple members at once using an array
# Add-ADGroupMember -Identity TestServerAccess -Members "user1", "user2", "user3"
