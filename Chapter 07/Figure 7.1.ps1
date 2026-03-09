# Figure 7.1 - Install and Import Pester Module
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates checking for, installing, and importing the Pester testing framework.

# ============================================================================
# CHECK INSTALLED PESTER VERSIONS
# ============================================================================

# List all available versions of Pester on the system
# Windows comes with Pester 3.4.0 preinstalled, but Pester 5.x is recommended
Get-Module -ListAvailable | Where-Object { $_.Name -eq "Pester" }

# Expected Output:
# ModuleType Version    Name      ExportedCommands
# ---------- -------    ----      ----------------
# Script     5.5.0      Pester    {Invoke-Pester, Describe, Context, It...}

# ============================================================================
# INSTALL PESTER MODULE
# ============================================================================

# Install the latest version of Pester from PowerShell Gallery
# -Force overwrites any existing version
Install-Module Pester -Force

# Note: On Windows, you may need to run as Administrator
# Note: Use -Scope CurrentUser if you don't have admin rights:
# Install-Module Pester -Force -Scope CurrentUser

# ============================================================================
# IMPORT PESTER MODULE
# ============================================================================

# Import Pester into the current PowerShell session
# This makes Pester cmdlets available for use
Import-Module Pester

# ============================================================================
# VERIFY PESTER IS LOADED
# ============================================================================

# Confirm Pester is imported and view version information
Get-Module Pester

# Expected Output:
# ModuleType Version    Name      ExportedCommands
# ---------- -------    ----      ----------------
# Script     5.5.0      Pester    {Invoke-Pester, Describe, Context, It...}
