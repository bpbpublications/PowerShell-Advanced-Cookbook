# Figure 6.4 - Run Command After TrustedHosts Configuration
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates running a command after the remote host is added to TrustedHosts.

# ============================================================================
# INVOKE-COMMAND AFTER TRUSTEDHOSTS SETUP
# ============================================================================

# After adding the remote computer to TrustedHosts (Figure 6.3),
# Invoke-Command will now succeed in workgroup environments
# The credential prompt appears for authentication
Invoke-Command -ComputerName PS-Host01 -ScriptBlock { ipconfig } -Credential (Get-Credential)

# Expected Output:
# Windows PowerShell credential request dialog appears
# After authentication, ipconfig output from remote computer:
#
# Windows IP Configuration
# Ethernet adapter Ethernet:
#    IPv4 Address. . . . . . . . . . . : 192.168.1.100
#    Subnet Mask . . . . . . . . . . . : 255.255.255.0

# Note: Without proper TrustedHosts configuration, you would receive:
# "The WinRM client cannot process the request because the server name
#  cannot be resolved" or authentication errors

# Note: In domain environments, TrustedHosts is typically not required
# because Kerberos handles authentication automatically
