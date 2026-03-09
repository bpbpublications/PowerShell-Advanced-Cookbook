# Figure 7.2 - Verify Pester Installation
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates verifying Pester installation and viewing loaded module.

# ============================================================================
# CHECK INSTALLED PESTER VERSIONS
# ============================================================================

# List all available versions of Pester installed on the system
# Multiple versions can coexist (e.g., 3.4.0 bundled with Windows + 5.x installed)
Get-Module -ListAvailable | Where-Object { $_.Name -eq "Pester" }

# Expected Output:
# ModuleType Version    Name      ExportedCommands
# ---------- -------    ----      ----------------
# Script     5.5.0      Pester    {Invoke-Pester, Describe, Context, It...}
# Script     3.4.0      Pester    {Invoke-Pester, Describe, Context, It...}

# ============================================================================
# INSTALL PESTER MODULE
# ============================================================================

# Install or update to the latest Pester version
Install-Module Pester -Force

# ============================================================================
# IMPORT PESTER MODULE
# ============================================================================

# Import the module to make Pester cmdlets available
Import-Module Pester

# ============================================================================
# VIEW CURRENTLY LOADED PESTER MODULE
# ============================================================================

# Display the currently loaded Pester module
# This shows only the active version in the current session
Get-Module Pester

# Expected Output:
# ModuleType Version    Name      ExportedCommands
# ---------- -------    ----      ----------------
# Script     5.5.0      Pester    {Invoke-Pester, Describe, Context, It...}

# Note: To import a specific version:
# Import-Module Pester -RequiredVersion 5.5.0
