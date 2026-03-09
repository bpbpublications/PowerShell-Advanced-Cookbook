# Recipe: Setting Up the ActiveDirectory Module
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates how to set up and verify the ActiveDirectory PowerShell module.

# ============================================================================
# PREREQUISITES
# ============================================================================

# The ActiveDirectory module requires one of the following:
#
# Option 1: Windows Server with Active Directory Domain Services (AD DS)
#   - The module is automatically available on domain controllers
#   - Also available on servers with AD DS management tools installed
#
# Option 2: Windows 10/11 with Remote Server Administration Tools (RSAT)
#   - Install via Settings > Apps > Optional Features > Add a feature
#   - Search for "RSAT: Active Directory Domain Services"
#   - Or use PowerShell: Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0

# ============================================================================
# IMPORT THE MODULE
# ============================================================================

# Import the ActiveDirectory module
# This loads all AD cmdlets into the current session
Import-Module ActiveDirectory

# ============================================================================
# VERIFY MODULE IS LOADED
# ============================================================================

# Check that the module is imported and view its details
Get-Module ActiveDirectory

# Expected Output:
# ModuleType Version    Name             ExportedCommands
# ---------- -------    ----             ----------------
# Manifest   1.0.1.0    ActiveDirectory  {Add-ADCentralAccessPolicyMember, ...}

# ============================================================================
# LIST ALL MODULE COMMANDS
# ============================================================================

# Get all cmdlets available in the ActiveDirectory module
Get-Command -Module ActiveDirectory

# Expected Output: List of 100+ cmdlets including:
# Get-ADUser, New-ADUser, Set-ADUser, Remove-ADUser
# Get-ADGroup, New-ADGroup, Set-ADGroup, Remove-ADGroup
# Get-ADComputer, Get-ADOrganizationalUnit, Get-ADDomain
# ...

# ============================================================================
# COMMON COMMAND CATEGORIES
# ============================================================================

# User Management:     Get-ADUser, New-ADUser, Set-ADUser, Remove-ADUser
# Group Management:    Get-ADGroup, New-ADGroup, Add-ADGroupMember
# Computer Management: Get-ADComputer, New-ADComputer, Set-ADComputer
# OU Management:       Get-ADOrganizationalUnit, New-ADOrganizationalUnit
# Domain Info:         Get-ADDomain, Get-ADForest, Get-ADDomainController
