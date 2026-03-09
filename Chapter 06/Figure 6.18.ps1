# Figure 6.18 - Retrieve Specific Credential
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates retrieving a specific credential from Windows Credential Manager.

# ============================================================================
# GET CREDENTIAL BY TARGET NAME
# ============================================================================

# -Target specifies the credential name/identifier in Credential Manager
# This retrieves credentials previously saved with that target name
$Credential = Get-StoredCredential -Target PS-HOST01
$Credential

# Expected Output:
# Target          : PS-HOST01
# UserName        : DOMAIN\adminuser
# Password        : System.Security.SecureString
# LastWriteTime   : 1/15/2024 10:30:00 AM
# Type            : Generic

# Note: The syntax error in the original "-Target" should not have a space
# Correct: Get-StoredCredential -Target PS-HOST01
# The credential object can be used directly with remoting cmdlets:
# New-PSSession -ComputerName PS-HOST01 -Credential $Credential

# To add a credential to Credential Manager:
# New-StoredCredential -Target PS-HOST01 -UserName "DOMAIN\user" -Password "secret" -Type Generic

# To remove a credential:
# Remove-StoredCredential -Target PS-HOST01
