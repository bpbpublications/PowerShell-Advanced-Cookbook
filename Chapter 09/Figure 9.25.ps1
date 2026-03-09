# Figure 9.25 - Combine Filter and SearchBase
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates combining -Filter and -SearchBase for precise queries.

# ============================================================================
# COMBINE FILTER AND SEARCHBASE
# ============================================================================

# Search within DK OU for users with specific job title
# This is the most efficient way to query AD
Get-ADUser -Filter "Title -eq 'Helpdesk'" `
    -SearchBase "OU=DK,OU=ADUsers,DC=moppleit,DC=dk" `
    -Properties Title | `
    Select-Object Name, SamAccountName, Title, DistinguishedName

# Expected Output:
# Name             SamAccountName  Title     DistinguishedName
# ----             --------------  -----     -----------------
# Sophia Anderson  soan            Helpdesk  CN=Sophia Anderson,OU=DK,OU=ADUsers,...
# ...

# ============================================================================
# QUERY OPTIMIZATION
# ============================================================================

# Combining -Filter and -SearchBase provides:
# 1. Server-side filtering (efficient)
# 2. Limited search scope (faster)
# 3. Precise results (less post-processing needed)
