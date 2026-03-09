# Figure 5.34 - Importing an Installed Module
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates importing a module that was installed from a repository.
# Installed modules can be imported by name without specifying a path.

# ============================================================================
# IMPORT INSTALLED MODULE
# ============================================================================

# Import the Logging module (installed from repository)
# No path needed - PowerShell searches $env:PSModulePath
Import-Module Logging

# Verify the module is loaded
Get-Module

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# ModuleType Version    PreRelease Name                   ExportedCommands
# ---------- -------    ---------- ----                   ----------------
# Manifest   7.0.0.0               Microsoft.PowerShell.Management {Add-Content, ...}
# Manifest   7.0.0.0               Microsoft.PowerShell.Utility    {Add-Member, ...}
# Script     1.0.0                 Logging                         {Add-LogToJson}

# ============================================================================
# MODULE AUTO-LOADING
# ============================================================================

# In PowerShell 3.0+, modules are automatically loaded when you call
# one of their commands. You don't need to explicitly Import-Module:

# This automatically imports the Logging module:
# Add-LogToJson -LogFilePath test.json -Message "Test"

# Module auto-loading settings:
# $PSModuleAutoLoadingPreference = "All"      # Default - auto-load all
# $PSModuleAutoLoadingPreference = "ModuleQualified"  # Only Module\Command syntax
# $PSModuleAutoLoadingPreference = "None"     # No auto-loading

# ============================================================================
# IMPORTING SPECIFIC VERSIONS
# ============================================================================

# If multiple versions are installed:
# Get-Module -ListAvailable -Name Logging

# Import specific version:
# Import-Module Logging -RequiredVersion 1.0.0

# Import minimum version:
# Import-Module Logging -MinimumVersion 1.0.0

# ============================================================================
# MODULE LOADING PRIORITY
# ============================================================================

# PowerShell searches these paths in order:
# 1. Current session (already loaded)
# 2. $env:PSModulePath directories (left to right)
# 3. User modules are checked before system modules

# View search order:
# $env:PSModulePath -split [IO.Path]::PathSeparator

