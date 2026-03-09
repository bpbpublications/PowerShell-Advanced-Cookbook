# Figure 6.17 - Windows Credential Manager Module
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates installing and using the CredentialManager module.

# ============================================================================
# INSTALL CREDENTIALMANAGER MODULE
# ============================================================================

# Install the CredentialManager module from PowerShell Gallery
# -Scope AllUsers requires Administrator privileges
# Use -Scope CurrentUser for non-admin installation
Install-Module CredentialManager -Scope AllUsers

# ============================================================================
# IMPORT MODULE INTO SESSION
# ============================================================================

# Import the module to make its cmdlets available
# Not required if using PowerShell 3+ auto-loading
Import-Module CredentialManager

# ============================================================================
# RETRIEVE ALL STORED CREDENTIALS
# ============================================================================

# Get-StoredCredential retrieves credentials from Windows Credential Manager
# These are the same credentials visible in Control Panel > Credential Manager
Get-StoredCredential

# Expected Output:
# Target          : PS-HOST01
# UserName        : DOMAIN\adminuser
# Password        : System.Security.SecureString
# LastWriteTime   : 1/15/2024 10:30:00 AM
# Type            : Generic
#
# Target          : ApiKey
# UserName        : ApiUser
# ...

# Benefits of Credential Manager:
# - Credentials persist across sessions and reboots
# - Centralized management through Windows UI or PowerShell
# - Can store various credential types (Windows, Generic, Certificate)
# - More secure than hardcoding or file-based storage
