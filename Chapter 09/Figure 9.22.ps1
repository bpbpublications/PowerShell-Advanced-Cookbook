# Figure 9.22 - Filter AD Groups by Description
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates filtering AD groups by a specific property.

# ============================================================================
# FILTER GROUPS BY DESCRIPTION
# ============================================================================

# Query AD Groups with a specific Description property value
Get-ADGroup -Filter "Description -eq 'GB'" `
    -Properties Description | `
    Select-Object Name, Description

# Expected Output:
# Name         Description
# ----         -----------
# EmployeesGB  GB
# ...

# ============================================================================
# GROUP FILTERING TIPS
# ============================================================================

# - Groups support the same filter syntax as users
# - Common properties to filter: Name, Description, GroupScope, GroupCategory
# - Use -like for partial matches: "Name -like '*Server*'"
