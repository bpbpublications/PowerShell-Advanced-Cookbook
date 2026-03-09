# Figure 9.29 - Bulk Add Users to Group
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates two methods for bulk adding users to a group.

# ============================================================================
# METHOD 1: USING FOREACH-OBJECT (ONE AT A TIME)
# ============================================================================

# Filter the target group
$Group = Get-ADGroup `
    -Filter "Name -eq 'Employees' -and Description -eq 'DK'"

# Add users one at a time using ForEach-Object
Get-ADUser `
    -Filter "Country -eq 'DK' -and Title -eq 'Employee'" | `
    ForEach-Object {
        Add-ADGroupMember -Identity $Group -Members $_
    }

# ============================================================================
# METHOD 2: USING -MEMBERS ARRAY (ALL AT ONCE - RECOMMENDED)
# ============================================================================

# Filter the target group
$Group = Get-ADGroup `
    -Filter "Name -eq 'Employees' -and Description -eq 'DK'"

# Filter users into a variable
$Users = Get-ADUser `
    -Filter "Country -eq 'DK' -and Title -eq 'Employee'"

# Add all filtered users to the group at once
Add-ADGroupMember -Identity $Group -Members $Users

# ============================================================================
# VERIFY ADDED USERS
# ============================================================================

# Confirm the users were added to the group
Get-ADGroup `
    -Filter "Name -eq 'Employees' -and Description -eq 'DK'" `
    -Properties Members

# ============================================================================
# PERFORMANCE NOTE
# ============================================================================

# Method 2 is faster for large user sets because:
# - Single LDAP operation vs. multiple operations
# - Less network round-trips to domain controller
