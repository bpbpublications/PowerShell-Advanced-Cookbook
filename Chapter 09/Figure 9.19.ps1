# Figure 9.19 - Query All AD Users with Select Properties
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates querying all AD users with specific properties.

# ============================================================================
# QUERY ALL AD USERS
# ============================================================================

# Get all AD users with additional properties
# -Filter * returns all users
# -Properties retrieves non-default attributes
Get-ADUser -Filter * `
    -Properties Country, Title | `
    Select-Object Name, SamAccountName, Country, Title

# Expected Output:
# Name                SamAccountName  Country  Title
# ----                --------------  -------  -----
# Morten Hansen       meh             DK       Administrator
# John Wilkins        jowi            GB       Developer
# ...

# ============================================================================
# PERFORMANCE NOTE
# ============================================================================

# - Only request properties you need (don't use -Properties *)
# - Using -Filter * on large domains can be slow
# - Consider using -SearchBase to limit scope
