# Figure 6.24 - Create Session with SSL/Certificate Authentication
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates certificate-based authentication without password prompts.

# ============================================================================
# CREATE SESSION WITH CERTIFICATE-BASED AUTHENTICATION
# ============================================================================

# -UseSSL enables HTTPS transport (port 5986)
# When certificate-based authentication is configured:
# - No credential prompt is required
# - Client certificate is used for authentication
# - Connection is encrypted end-to-end
$Session = New-PSSession -ComputerName PS-HOST01 -UseSSL

# Prerequisites for certificate-based authentication:
# 1. Server has HTTPS WinRM listener configured
# 2. Server's SSL certificate is trusted by client
# 3. Client certificate is mapped to a user account on server
# 4. Certificate-based auth is enabled on server

# Expected behavior:
# - No credential dialog appears
# - Session connects over HTTPS (port 5986)
# - Mutual TLS authentication occurs
# - Session established with certificate-mapped user

# If server certificate is self-signed, may need:
# $Session = New-PSSession -ComputerName PS-HOST01 -UseSSL `
#     -SessionOption (New-PSSessionOption -SkipCACheck -SkipCNCheck)

# Note: -SkipCACheck and -SkipCNCheck reduce security
# Only use for testing or when you trust the self-signed cert
