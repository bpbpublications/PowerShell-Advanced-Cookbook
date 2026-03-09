# Figure 6.3 - Add Computer to TrustedHosts
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires Administrator privileges)
# Adds a remote host to the TrustedHosts list for workgroup environments.

# ============================================================================
# CONFIGURE TRUSTEDHOSTS
# ============================================================================

# In workgroup environments (non-domain), you must add remote computers
# to the TrustedHosts list before connecting to them
# WSMan:\localhost\client\TrustedHosts is a WS-Management configuration path
Set-Item WSMan:\localhost\client\TrustedHosts -Value "PS-Host01"

# Expected Output:
# WinRM Security Configuration dialog may appear asking for confirmation
# No output on success

# Why TrustedHosts is needed:
# - Kerberos authentication is not available in workgroup environments
# - NTLM authentication requires explicit trust configuration
# - This setting tells WinRM which computers to trust for NTLM auth

# Security Note:
# - Only add computers you trust to this list
# - Avoid using wildcards (*) in production environments
# - Consider using HTTPS-based remoting for better security
