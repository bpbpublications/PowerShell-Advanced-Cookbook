# Figure 9.27 - Bulk Update User Property
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates bulk updating a property for all users.

# ============================================================================
# BULK UPDATE COMPANY PROPERTY
# ============================================================================

# Update the Company property for all users
# Pipeline passes each user to Set-ADUser
Get-ADUser -Filter * `
    -Properties Company | `
    Set-ADUser -Company "MoppleIT"

# ============================================================================
# VERIFY THE UPDATE
# ============================================================================

# List all users with their updated Company property
Get-ADUser -Filter * `
    -Properties Company | `
    Select-Object Name, Company

# Expected Output:
# Name             Company
# ----             -------
# Morten Hansen    MoppleIT
# John Wilkins     MoppleIT
# ...

# ============================================================================
# CAUTION
# ============================================================================

# This updates ALL users in the domain
# For targeted updates, use a more specific -Filter or -SearchBase
