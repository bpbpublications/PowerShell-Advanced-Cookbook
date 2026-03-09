# Figure 9.26 - List Users with Company Property
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Shows current Company property value for all users.

# ============================================================================
# LIST ALL USERS WITH COMPANY PROPERTY
# ============================================================================

# Get all AD users and display their Company property
Get-ADUser -Filter * `
    -Properties Company | `
    Select-Object Name, Company

# Expected Output:
# Name             Company
# ----             -------
# Morten Hansen
# John Wilkins
# ...

# Note: Company may be empty if not previously set
