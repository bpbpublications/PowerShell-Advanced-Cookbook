# Figure 6.2 - Run Command on Remote Host
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates running a single command on a remote computer using Invoke-Command.

# ============================================================================
# INVOKE-COMMAND WITH CREDENTIAL PROMPT
# ============================================================================

# Invoke-Command runs commands on local or remote computers
# -ComputerName: Specifies the target computer(s)
# -ScriptBlock: Contains the command(s) to execute remotely
# -Credential: Prompts for username/password or accepts a credential object
Invoke-Command -ComputerName PS-Host01 -ScriptBlock { ipconfig } -Credential (Get-Credential)

# Expected Output:
# Windows PowerShell credential request dialog appears
# After authentication, ipconfig output from remote computer is displayed:
#
# Windows IP Configuration
# Ethernet adapter Ethernet:
#    Connection-specific DNS Suffix  . : domain.local
#    IPv4 Address. . . . . . . . . . . : 192.168.1.100
#    Subnet Mask . . . . . . . . . . . : 255.255.255.0
#    Default Gateway . . . . . . . . . : 192.168.1.1

# Note: For multiple computers, use comma-separated list:
# Invoke-Command -ComputerName PS-Host01, PS-Host02 -ScriptBlock { ipconfig }

# Note: Get-Credential can be stored in a variable for reuse:
# $Cred = Get-Credential
# Invoke-Command -ComputerName PS-Host01 -ScriptBlock { ipconfig } -Credential $Cred
