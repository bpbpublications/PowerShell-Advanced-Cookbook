# Figure 6.7 - Use Session for Multiple Commands
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates reusing a persistent session for multiple remote commands.

# ============================================================================
# CREATE PERSISTENT SESSION
# ============================================================================

# Create a persistent session to reuse for multiple commands
$Session = New-PSSession -ComputerName "PS-Host01" `
    -Credential (Get-Credential) `
    -Name "Host01"

# ============================================================================
# EXECUTE MULTIPLE COMMANDS VIA SESSION
# ============================================================================

# Use -Session parameter instead of -ComputerName for persistent sessions
# This avoids re-authentication and maintains state

# Get the remote computer name
Invoke-Command -Session $Session -ScriptBlock { $Env:COMPUTERNAME }
# Expected Output: PS-HOST01

# Get the remote operating system name
Invoke-Command -Session $Session -ScriptBlock { (Get-ComputerInfo).OsName }
# Expected Output: Microsoft Windows Server 2022 Datacenter

# Run a script file on the remote computer using the session
Invoke-Command -Session $Session `
    -FilePath C:\Temp\GetComputerName.ps1 `
    -ArgumentList "$($Env:COMPUTERNAME)"
# Expected Output: This script is run on PS-HOST01 from YOURCOMPUTERNAME

# ============================================================================
# REFERENCE: GetComputerName.ps1 Script Content
# ============================================================================

# The GetComputerName.ps1 script should contain:
# [CmdletBinding()]
# param (
#     [String]$ClientHostName
# )
#
# Write-Output "This script is run on $($Env:COMPUTERNAME) from $ClientHostName"

# Key advantage: Variables created in one command persist in subsequent commands
# Example:
# Invoke-Command -Session $Session -ScriptBlock { $MyVar = "Hello" }
# Invoke-Command -Session $Session -ScriptBlock { $MyVar }  # Returns "Hello"
