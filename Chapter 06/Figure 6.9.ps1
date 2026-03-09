# Figure 6.9 - Session Lifecycle Management
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates viewing and removing remote sessions.

# ============================================================================
# VIEW ACTIVE SESSIONS
# ============================================================================

# Get-PSSession lists all active PowerShell sessions
Get-PSSession

# Expected Output:
# Id Name      ComputerName  ComputerType  State    ConfigurationName  Availability
# -- ----      ------------  ------------  -----    -----------------  ------------
#  1 Host01    PS-Host01     RemoteMachine Opened   Microsoft.PowerShell Available

# ============================================================================
# REMOVE A SESSION
# ============================================================================

# Remove-PSSession closes and cleans up the remote session
# Frees resources on both client and server
Remove-PSSession $Session

# ============================================================================
# VERIFY SESSION REMOVAL
# ============================================================================

# Confirm the session has been removed
Get-PSSession

# Expected Output: (empty - no active sessions)

# ============================================================================
# ATTEMPT COMMAND ON REMOVED SESSION
# ============================================================================

# Trying to use a removed session generates an error
Invoke-Command -Session $Session -ScriptBlock { $ENV:COMPUTERNAME }

# Expected Error:
# Cannot validate argument on parameter 'Session'. The session is not available.
# The session may have been closed or the connection lost.

# Best Practices:
# - Always remove sessions when work is complete
# - Use try/finally blocks to ensure cleanup
# - Remove-PSSession -Id 1,2,3 to remove multiple sessions
# - Get-PSSession | Remove-PSSession to remove all sessions
