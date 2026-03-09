# Figure 9.4 - List AD User and Group Cmdlets
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates how to discover AD cmdlets by noun.

# ============================================================================
# LIST USER MANAGEMENT CMDLETS
# ============================================================================

# Find all cmdlets in the AD module that work with users
Get-Command -Module ActiveDirectory -Noun "*User*"

# Expected Output includes:
# Get-ADUser, New-ADUser, Set-ADUser, Remove-ADUser
# Enable-ADAccount, Disable-ADAccount (also work with users)

# ============================================================================
# LIST GROUP MANAGEMENT CMDLETS
# ============================================================================

# Find all cmdlets in the AD module that work with groups
Get-Command -Module ActiveDirectory -Noun "*Group*"

# Expected Output includes:
# Get-ADGroup, New-ADGroup, Set-ADGroup, Remove-ADGroup
# Add-ADGroupMember, Remove-ADGroupMember, Get-ADGroupMember
# Add-ADPrincipalGroupMembership, Get-ADPrincipalGroupMembership

# ============================================================================
# DISCOVERY TIP
# ============================================================================

# Use -Noun with wildcards to discover related cmdlets:
# Get-Command -Module ActiveDirectory -Noun "*Computer*"
# Get-Command -Module ActiveDirectory -Noun "*Object*"
# Get-Command -Module ActiveDirectory -Noun "*OU*"
