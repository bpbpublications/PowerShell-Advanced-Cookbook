# Figure 9.12 - Modify AD Group Attributes
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates modifying AD group properties.

# ============================================================================
# MODIFY GROUP ATTRIBUTES
# ============================================================================

# Define attributes to update
$Params = @{
    Description = "Test server access group"
    DisplayName = "Test Server Access"
}

# Apply changes to the group
Set-ADGroup -Identity TestServerAccess @Params

# ============================================================================
# VERIFY MODIFICATIONS
# ============================================================================

# Get the modified AD group with updated properties
Get-ADGroup -Identity TestServerAccess -Properties Description, DisplayName

# Expected Output:
# Description       : Test server access group
# DisplayName       : Test Server Access
# DistinguishedName : CN=TestServerAccess,OU=Custom,OU=ADGroups,DC=moppleit,DC=dk
# GroupCategory     : Security
# GroupScope        : Global
# Name              : TestServerAccess
# ...
