# Figure 6.23 - Create Session with Credentials
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Standard approach to creating a remote session with credential prompt.

# ============================================================================
# CREATE SESSION WITH CREDENTIAL AUTHENTICATION
# ============================================================================

# Standard approach: Prompt for credentials each time
# This uses default HTTP transport (port 5985)
$Session = New-PSSession -ComputerName "PS-HOST01" -Credential (Get-Credential)

# Expected behavior:
# 1. Credential dialog appears requesting username and password
# 2. WinRM connects to PS-HOST01 on port 5985 (HTTP)
# 3. Session is established using Negotiate authentication
# 4. Session object is stored in $Session variable

# This is the traditional approach requiring:
# - Username and password each time
# - User interaction (cannot be fully automated)
# - Either domain membership or TrustedHosts configuration

# To use stored credentials instead:
# $Cred = Import-Clixml -Path C:\Secure\creds.xml
# $Session = New-PSSession -ComputerName "PS-HOST01" -Credential $Cred

# Or with Credential Manager:
# $Cred = Get-StoredCredential -Target PS-HOST01
# $Session = New-PSSession -ComputerName "PS-HOST01" -Credential $Cred
