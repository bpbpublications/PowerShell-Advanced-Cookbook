# Figure 5.23 - Importing a Local Module
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates importing a module from a local directory and
# verifying it was loaded successfully.

# ============================================================================
# PREREQUISITES
# ============================================================================

# Navigate to the parent directory containing the module
Set-Location ".\Modules"

# ============================================================================
# IMPORT LOCAL MODULE
# ============================================================================

# Import-Module loads a module into the current session
# Using a path imports the module from that specific location
Import-Module .\Logging

# Get-Module shows all currently loaded modules
Get-Module

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# ModuleType Version    PreRelease Name       ExportedCommands
# ---------- -------    ---------- ----       ----------------
# Script     1.0.0                 Logging    {Add-LogToJson}

# ============================================================================
# IMPORT-MODULE OPTIONS
# ============================================================================

# FORCE REIMPORT (reload after changes):
# Import-Module .\Logging -Force

# IMPORT WITH VERBOSE OUTPUT:
# Import-Module .\Logging -Verbose

# IMPORT SPECIFIC VERSION:
# Import-Module .\Logging -RequiredVersion 1.0.0

# IMPORT WITH CUSTOM PREFIX:
# Import-Module .\Logging -Prefix Log
# (Functions become: Add-LogLogToJson)

# CHECK IF MODULE EXISTS BEFORE IMPORTING:
# if (-not (Get-Module -Name Logging)) {
#     Import-Module .\Logging
# }

# ============================================================================
# REMOVING MODULES
# ============================================================================

# Remove a module from the current session:
# Remove-Module Logging

# Verify removal:
# Get-Module Logging  # Should return nothing

