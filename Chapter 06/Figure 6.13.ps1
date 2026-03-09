# Figure 6.13 - Create SecureString
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 7+)
# Demonstrates creating a SecureString for secure password handling.

# ============================================================================
# CREATE SECURESTRING FROM PLAIN TEXT
# ============================================================================

# ConvertTo-SecureString encrypts a plain text password
# -AsPlainText: Indicates input is plain text (not encrypted string)
# -Force: Required when using -AsPlainText to acknowledge security implications
$SecurePassword = ConvertTo-SecureString "MyPassword" -AsPlainText -Force

# Display the SecureString object (not the actual password)
$SecurePassword

# Expected Output:
# System.Security.SecureString

# ============================================================================
# SECURITY NOTES
# ============================================================================

# WARNING: Hardcoding passwords in scripts is a security risk!
# This example is for demonstration only.

# Better approaches:
# 1. Prompt user: $SecurePassword = Read-Host -AsSecureString "Enter password"
# 2. Use credential manager: Get-StoredCredential
# 3. Use Azure Key Vault or similar secrets management

# SecureString protects passwords in memory by:
# - Encrypting the data in memory
# - Preventing accidental display in logs
# - Limiting exposure during garbage collection

# To create a credential object with SecureString:
# $Credential = New-Object PSCredential("username", $SecurePassword)
