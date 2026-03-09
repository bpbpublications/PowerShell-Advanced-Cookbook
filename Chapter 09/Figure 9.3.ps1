# Figure 9.3 - List ActiveDirectory Module Details
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Shows how to view module information after importing.

# ============================================================================
# IMPORT AND VERIFY MODULE
# ============================================================================

# Import the module first
Import-Module ActiveDirectory

# View module details including version, exported commands count, etc.
Get-Module ActiveDirectory

# Expected Output:
# ModuleType Version    PreRelease Name             ExportedCommands
# ---------- -------    ---------- ----             ----------------
# Manifest   1.0.1.0               ActiveDirectory  {Add-ADCentralAccessPolicyMember, ...}

# ============================================================================
# USEFUL MODULE PROPERTIES
# ============================================================================

# The module object contains useful properties:
# - Version: The module version number
# - ExportedCommands: All cmdlets, functions, and aliases exported
# - Path: Location of the module on disk
# - ModuleBase: Base directory of the module
