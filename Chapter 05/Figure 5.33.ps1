# Figure 5.33 - Installing a Module from a Repository
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates installing a module from a PowerShell repository.
# Modules installed this way are available system-wide.

# ============================================================================
# CHECK AVAILABLE MODULES
# ============================================================================

# Check if module is already installed
Get-Module -ListAvailable | Where-Object { $_.Name -eq "Logging" }

# ============================================================================
# INSTALL MODULE
# ============================================================================

# Install-Module downloads and installs a module from a repository
# -Repository: Specifies which repository to install from
Install-Module Logging -Repository PsRepo

# ============================================================================
# VERIFY INSTALLATION
# ============================================================================

# Confirm the module is now available
Get-Module -ListAvailable | Where-Object { $_.Name -eq "Logging" }

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Before installation:
# (No output - module not found)

# After installation:
# ModuleType Version    PreRelease Name       ExportedCommands
# ---------- -------    ---------- ----       ----------------
# Script     1.0.0                 Logging    {Add-LogToJson}

# ============================================================================
# INSTALL-MODULE OPTIONS
# ============================================================================

# INSTALL FOR CURRENT USER ONLY (no admin required):
# Install-Module Logging -Scope CurrentUser

# INSTALL SPECIFIC VERSION:
# Install-Module Logging -RequiredVersion 1.0.0

# FORCE REINSTALL:
# Install-Module Logging -Force

# ALLOW PRERELEASE VERSIONS:
# Install-Module Logging -AllowPrerelease

# SKIP PUBLISHER CHECK (if certificate issues):
# Install-Module Logging -SkipPublisherCheck

# INSTALL WITHOUT PROMPTS (for automation):
# Install-Module Logging -Force -Confirm:$false

# ============================================================================
# INSTALLATION LOCATIONS
# ============================================================================

# ALLUSERS SCOPE (default, requires admin):
# Windows: C:\Program Files\PowerShell\Modules
# Linux/macOS: /usr/local/share/powershell/Modules

# CURRENTUSER SCOPE:
# Windows: $HOME\Documents\PowerShell\Modules
# Linux/macOS: ~/.local/share/powershell/Modules

# View module paths:
# $env:PSModulePath -split [IO.Path]::PathSeparator

