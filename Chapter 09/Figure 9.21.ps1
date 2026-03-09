# Figure 9.21 - Filter AD Users with Multiple Conditions
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates filtering with multiple conditions using -and.

# ============================================================================
# FILTER WITH MULTIPLE CONDITIONS
# ============================================================================

# Query AD users in Denmark with job title 'Employee'
# Use -and to combine filter conditions
Get-ADUser -Filter "Country -eq 'DK' -and Title -eq 'Employee'" `
    -Properties Country, Title | `
    Select-Object Name, SamAccountName, Country, Title

# Expected Output:
# Name                SamAccountName  Country  Title
# ----                --------------  -------  -----
# Liam Clark          licl            DK       Employee
# ...

# ============================================================================
# FILTER OPERATORS
# ============================================================================

# -and : Both conditions must be true
# -or  : Either condition can be true
# -not : Negates a condition
# Example: "Country -eq 'DK' -or Country -eq 'GB'"
