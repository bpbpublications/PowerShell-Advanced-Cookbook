# Figure 9.28 - Query Users and Groups for Bulk Operations
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates querying before performing bulk group membership operations.

# ============================================================================
# QUERY THE TARGET GROUP
# ============================================================================

# Find the specific group using filter
# Check current members before adding
Get-ADGroup `
    -Filter "Name -eq 'Employees' -and Description -eq 'DK'" `
    -Properties Members

# ============================================================================
# QUERY THE USERS TO ADD
# ============================================================================

# Find users matching the criteria
# Verify the list before adding to group
Get-ADUser `
    -Filter "Country -eq 'DK' -and Title -eq 'Employee'" `
    -Properties Country, Title | `
    Select-Object Name, Country, Title

# Expected Output:
# Name             Country  Title
# ----             -------  -----
# Liam Clark       DK       Employee
# ...

# ============================================================================
# BEST PRACTICE
# ============================================================================

# Always verify your queries before bulk operations:
# 1. Query the target group to confirm it exists
# 2. Query the users to confirm the right set is selected
# 3. Then proceed with the bulk add (see next figure)
