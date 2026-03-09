# Figure 5.29 - Using PowerShellGet Module
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates importing PowerShellGet and viewing its available commands.
# PowerShellGet is used to find, install, and publish PowerShell modules.

# ============================================================================
# IMPORT POWERSHELLGET
# ============================================================================

# PowerShellGet is the module management module
# It provides commands for working with PowerShell Gallery and custom repositories
Import-Module PowerShellGet

# View all commands available in PowerShellGet
Get-Command -Module PowerShellGet

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# CommandType     Name                                               Version    Source
# -----------     ----                                               -------    ------
# Function        Find-Command                                       2.2.5      PowerShellGet
# Function        Find-DscResource                                   2.2.5      PowerShellGet
# Function        Find-Module                                        2.2.5      PowerShellGet
# Function        Find-RoleCapability                                2.2.5      PowerShellGet
# Function        Find-Script                                        2.2.5      PowerShellGet
# Function        Get-InstalledModule                                2.2.5      PowerShellGet
# Function        Get-InstalledScript                                2.2.5      PowerShellGet
# Function        Get-PSRepository                                   2.2.5      PowerShellGet
# Function        Install-Module                                     2.2.5      PowerShellGet
# Function        Install-Script                                     2.2.5      PowerShellGet
# Function        Publish-Module                                     2.2.5      PowerShellGet
# Function        Publish-Script                                     2.2.5      PowerShellGet
# ...

# ============================================================================
# KEY POWERSHELLGET COMMANDS
# ============================================================================

# FINDING MODULES:
# Find-Module -Name "Pester"           # Find by name
# Find-Module -Tag "Azure"             # Find by tag
# Find-Module -Command "Get-*"         # Find by command name

# INSTALLING MODULES:
# Install-Module -Name "Pester"        # Install from PSGallery
# Install-Module -Name "Pester" -Scope CurrentUser  # Install for current user only

# MANAGING INSTALLED MODULES:
# Get-InstalledModule                  # List all installed modules
# Update-Module -Name "Pester"         # Update to latest version
# Uninstall-Module -Name "Pester"      # Remove module

# PUBLISHING MODULES:
# Publish-Module -Path ".\MyModule" -NuGetApiKey $ApiKey

# ============================================================================
# POWERSHELLGET VERSIONS
# ============================================================================

# Check PowerShellGet version:
# (Get-Module PowerShellGet).Version

# PowerShell 7+ includes PowerShellGet 3.x (PSResourceGet)
# Older systems may have PowerShellGet 2.x or 1.x

# Update PowerShellGet:
# Install-Module PowerShellGet -Force -AllowClobber

