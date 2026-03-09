# Figure 6.6 - Create and View Remote Sessions
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates creating persistent PSSession connections.

# ============================================================================
# CREATE PERSISTENT SESSION
# ============================================================================

# New-PSSession creates a persistent connection to a remote computer
# Unlike Invoke-Command alone, sessions maintain state between commands
# -Name provides a friendly identifier for the session
$Session = New-PSSession -ComputerName "PS-Host01" `
    -Credential (Get-Credential) `
    -Name "Host01"

# ============================================================================
# VIEW ACTIVE SESSIONS
# ============================================================================

# Get-PSSession displays all active sessions on the local computer
# Shows session details: Id, Name, ComputerName, State, ConfigurationName
Get-PSSession

# Expected Output:
# Id Name      ComputerName  ComputerType  State    ConfigurationName  Availability
# -- ----      ------------  ------------  -----    -----------------  ------------
#  1 Host01    PS-Host01     RemoteMachine Opened   Microsoft.PowerShell Available

# Benefits of persistent sessions:
# - Maintains variables and loaded modules between commands
# - Faster than creating new connections for each command
# - Can run multiple commands without re-authenticating
# - Supports Enter-PSSession for interactive use

# Note: Sessions consume resources on both client and server
# Always remove sessions when no longer needed: Remove-PSSession $Session
