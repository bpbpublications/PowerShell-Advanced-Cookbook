# Figure 5.26 - Viewing Loaded Module Information
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates how to view information about loaded modules
# using Get-Module.

# ============================================================================
# PREREQUISITES
# ============================================================================

# Navigate to the modules directory and import the module
Set-Location ".\Modules"
Import-Module .\Logging

# ============================================================================
# VIEW LOADED MODULES
# ============================================================================

# Get-Module lists all modules currently loaded in the session
Get-Module

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# ModuleType Version    PreRelease Name                   ExportedCommands
# ---------- -------    ---------- ----                   ----------------
# Manifest   7.0.0.0               Microsoft.PowerShell.Management {Add-Content, Clear-Content, ...}
# Manifest   7.0.0.0               Microsoft.PowerShell.Utility    {Add-Member, Compare-Object, ...}
# Script     1.0.0                 Logging                         {Add-LogToJson}

# ============================================================================
# GET-MODULE OPTIONS
# ============================================================================

# VIEW SPECIFIC MODULE:
# Get-Module -Name Logging

# VIEW ALL AVAILABLE MODULES (not just loaded):
# Get-Module -ListAvailable

# VIEW DETAILED MODULE INFO:
# Get-Module -Name Logging | Format-List *

# FILTER BY MODULE TYPE:
# Get-Module | Where-Object ModuleType -eq "Script"

# ============================================================================
# MODULE INFORMATION PROPERTIES
# ============================================================================

# Key properties returned by Get-Module:
# - Name: Module name
# - Version: Module version number
# - ModuleType: Script, Manifest, Binary, or Cim
# - Path: Full path to the module
# - Description: Module description
# - Author: Module author
# - ExportedCommands: Functions/cmdlets exported
# - ExportedAliases: Aliases exported
# - ExportedVariables: Variables exported

# Get detailed properties:
# (Get-Module Logging).ExportedCommands
# (Get-Module Logging).Path
# (Get-Module Logging).Description

