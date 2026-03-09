# Figure 6.25 - Import Certificate and Establish SSL Session
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates importing server certificate and creating secure session.

# ============================================================================
# IMPORT SERVER CERTIFICATE TO TRUSTED STORE
# ============================================================================

# Import the server's public certificate to the local machine's
# Trusted Root Certification Authorities store
# This allows the client to trust the server's SSL certificate
Import-Certificate -FilePath C:\Temp\ps-host01.cer `
    -CertStoreLocation Cert:\LocalMachine\Root

# Expected Output:
# Thumbprint                                Subject
# ----------                                -------
# ABC123DEF456...                           CN=ps-host01

# ============================================================================
# CREATE SSL SESSION
# ============================================================================

# After importing the certificate, SSL connections will be trusted
$Session = New-PSSession -ComputerName PS-HOST01 -UseSSL

# ============================================================================
# ENTER INTERACTIVE SESSION
# ============================================================================

# Enter the secure session for interactive work
Enter-PSSession $Session

# Expected prompt:
# [PS-HOST01]: PS C:\Users\AdminUser>

# Why certificate import is needed:
# - Self-signed certificates are not trusted by default
# - Importing to Root store establishes trust chain
# - Prevents SSL/TLS errors during connection

# Certificate locations:
# - Cert:\LocalMachine\Root - Trusted for all users on machine
# - Cert:\CurrentUser\Root - Trusted for current user only

# To verify certificate was imported:
# Get-ChildItem Cert:\LocalMachine\Root | Where-Object Subject -like "*ps-host01*"
