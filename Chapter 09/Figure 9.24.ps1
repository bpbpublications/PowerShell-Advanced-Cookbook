# Figure 9.24 - Limit Search Scope with SearchBase
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates using -SearchBase to limit the search scope.

# ============================================================================
# SEARCH IN DEFAULT USERS CONTAINER
# ============================================================================

# Search only within the default Users container
Get-ADUser -Filter * -SearchBase "CN=Users,DC=moppleit,DC=dk" | `
    Select-Object Name, SamAccountName, DistinguishedName

# ============================================================================
# SEARCH IN SPECIFIC OU
# ============================================================================

# Search only within the DK organizational unit
Get-ADUser -Filter * -SearchBase "OU=DK,OU=ADUsers,DC=moppleit,DC=dk" | `
    Select-Object Name, SamAccountName, DistinguishedName

# Expected Output:
# Name            SamAccountName  DistinguishedName
# ----            --------------  -----------------
# Morten Hansen   meh             CN=Morten Hansen,OU=DK,OU=ADUsers,DC=moppleit,DC=dk
# ...

# ============================================================================
# SEARCHBASE BENEFITS
# ============================================================================

# - Limits query to specific container/OU
# - Improves performance on large domains
# - Reduces unnecessary results
# - Can be combined with -Filter for precise queries
