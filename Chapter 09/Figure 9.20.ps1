# Figure 9.20 - Filter AD Users by Country
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates filtering AD users by a specific attribute value.

# ============================================================================
# FILTER BY COUNTRY
# ============================================================================

# Query AD users in Denmark (Country = 'DK')
# The -Filter parameter uses AD query syntax
Get-ADUser -Filter "Country -eq 'DK'" `
    -Properties Country, Title | `
    Select-Object Name, SamAccountName, Country, Title

# Expected Output:
# Name                SamAccountName  Country  Title
# ----                --------------  -------  -----
# Morten Hansen       meh             DK       Administrator
# Sophia Anderson     soan            DK       Helpdesk
# William Brown       wibr            DK       Manager
# ...

# ============================================================================
# FILTER SYNTAX
# ============================================================================

# -Filter uses AD query language (not PowerShell operators):
# -eq, -ne, -lt, -le, -gt, -ge, -like, -notlike
# String values must be in single quotes within the filter
