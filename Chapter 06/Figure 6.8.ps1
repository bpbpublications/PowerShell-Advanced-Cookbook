# Figure 6.8 - Interactive Remote Session
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates entering an interactive session on a remote computer.

# ============================================================================
# CREATE SESSION AND ENTER INTERACTIVE MODE
# ============================================================================

# Create a persistent session
$Session = New-PSSession -ComputerName "PS-Host01" `
    -Credential (Get-Credential) `
    -Name "Host01"

# Enter-PSSession starts an interactive session with the remote computer
# Your prompt changes to indicate you're connected remotely
# All commands you type are executed on the remote computer
Enter-PSSession $Session

# Expected prompt change:
# PS C:\Users\YourUser>
# becomes:
# [PS-Host01]: PS C:\Users\RemoteUser>

# ============================================================================
# EXIT INTERACTIVE SESSION
# ============================================================================

# Exit-PSSession returns you to your local PowerShell session
# The remote session remains open and can be re-entered
Exit-PSSession

# Expected prompt change:
# [PS-Host01]: PS C:\Users\RemoteUser>
# becomes:
# PS C:\Users\YourUser>

# Notes:
# - Enter-PSSession is for interactive work (like SSH)
# - Invoke-Command is for running scripts/commands programmatically
# - Variables created during interactive session persist in that session
# - Use Ctrl+C to break out of a hung remote session

# Alternative: Enter session directly without storing in variable
# Enter-PSSession -ComputerName PS-Host01 -Credential (Get-Credential)
