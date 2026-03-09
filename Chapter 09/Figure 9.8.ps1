# Figure 9.8 - Non-Parameterized Attribute Operations
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates Add, Replace, Remove, and Clear operations for AD attributes.

# ============================================================================
# ADD A NON-PARAMETERIZED ATTRIBUTE
# ============================================================================

# Some attributes don't have dedicated parameters in Set-ADUser
# Use -Add with a hashtable to add values
$Add = @{ EmployeeType = "Manager" }
Set-ADUser -Identity "meh" -Add $Add

# ============================================================================
# REPLACE AN ATTRIBUTE VALUE
# ============================================================================

# Use -Replace to update an existing attribute value
$Replace = @{ Info = "Administrator, Developer, DevOps and author" }
Set-ADUser -Identity "meh" -Replace $Replace

# Verify the changes
Get-ADUser meh -Properties EmployeeType, Info, TelephoneNumber

# ============================================================================
# REMOVE A SPECIFIC ATTRIBUTE VALUE
# ============================================================================

# Use -Remove to delete a specific value from an attribute
# Useful for multi-valued attributes
$Remove = @{ TelephoneNumber = "+4512345678" }
Set-ADUser -Identity "meh" -Remove $Remove

# ============================================================================
# CLEAR AN ATTRIBUTE COMPLETELY
# ============================================================================

# Use -Clear to remove all values from an attribute
# Pass the attribute name as a string (not hashtable)
$Clear = "EmployeeType"
Set-ADUser -Identity "meh" -Clear $Clear

# Verify final state
Get-ADUser meh -Properties EmployeeType, Info, TelephoneNumber

# Expected Output:
# EmployeeType and TelephoneNumber should be empty
# Info should contain the replaced value
