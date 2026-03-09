# Recipe: Certificate-Based Authentication
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires Administrator privileges)
# Complete walkthrough for setting up certificate-based WinRM authentication.

# ============================================================================
# OVERVIEW
# ============================================================================

# Certificate-based authentication provides:
# - Passwordless authentication for automated scripts
# - Encrypted transport (HTTPS on port 5986)
# - Mutual authentication between client and server
# - Better security than storing passwords in scripts

# ============================================================================
# STEP 1: CREATE SELF-SIGNED CERTIFICATE (ON HOST/SERVER)
# ============================================================================

# The DNS name MUST match the hostname clients will use to connect
$Dns = "ps-host01"
$Cert = New-SelfSignedCertificate -DnsName $Dns `
    -CertStoreLocation Cert:\LocalMachine\My

# Expected Output:
# Thumbprint                                Subject
# ----------                                -------
# ABC123DEF456789...                        CN=ps-host01

# ============================================================================
# STEP 2: EXPORT CERTIFICATES (ON HOST/SERVER)
# ============================================================================

# Export the PUBLIC key certificate (for client to import)
# This file can be safely distributed - contains no private key
$Cert | Export-Certificate -FilePath C:\Temp\ps-host01.cer

# Export certificate WITH private key (for backup purposes only)
# Store this securely - it contains the private key!
$Cert | Export-PfxCertificate -FilePath C:\Temp\ps-host01.pfx `
    -Password (ConvertTo-SecureString "CertPass" -AsPlainText -Force)

# ============================================================================
# STEP 3: ENABLE CERTIFICATE-BASED AUTHENTICATION (ON HOST/SERVER)
# ============================================================================

# Enable certificate authentication in WinRM service
Set-Item WSMan:\localhost\Service\Auth\Certificate -Value $true

# Verify the setting was applied
winrm get winrm/config

# Look for: Service > Auth > Certificate = true

# ============================================================================
# STEP 4: CREATE HTTPS LISTENER (ON HOST/SERVER)
# ============================================================================

# Create new HTTPS WinRM listener using the certificate
# Address * means listen on all network interfaces
New-Item -Path WSMan:\localhost\listener -Transport HTTPS `
    -Address * `
    -CertificateThumbPrint $Cert.Thumbprint `
    -HostName ps-host01 `
    -Force

# View all listeners to verify
Get-ChildItem WSMan:\localhost\Listener\

# ============================================================================
# STEP 4.1: REMOVE HTTP LISTENER (OPTIONAL - FOR SECURITY)
# ============================================================================

# Remove the default HTTP listener to force HTTPS-only connections
winrm delete winrm/config/listener?Address=*+Transport=HTTP

# ============================================================================
# STEP 5: CONFIGURE FIREWALL (ON HOST/SERVER)
# ============================================================================

# Create firewall rule for WinRM HTTPS (port 5986)
$Rule = "Windows Remote Management (HTTPS-In)"
New-NetFirewallRule -DisplayName $Rule `
    -Name $Rule `
    -Group $Rule `
    -Profile Any `
    -LocalPort 5986 `
    -Protocol TCP

# ============================================================================
# CLIENT CONFIGURATION
# ============================================================================

# STEP 1: Import the server's public certificate
# Copy ps-host01.cer from server to client, then import to Root store
Import-Certificate -FilePath C:\Temp\ps-host01.cer `
    -CertStoreLocation Cert:\LocalMachine\Root

# STEP 2: Create session using SSL
# The -UseSSL switch connects over HTTPS (port 5986)
$Session = New-PSSession -ComputerName PS-HOST01 -UseSSL

# ============================================================================
# TROUBLESHOOTING
# ============================================================================

# If connection fails, check:
# 1. Certificate subject matches hostname being used
# 2. Certificate is in LocalMachine\My on server
# 3. Certificate is in LocalMachine\Root on client
# 4. HTTPS listener is configured and enabled
# 5. Firewall allows port 5986
# 6. DNS resolves hostname correctly

# To skip certificate validation (testing only):
# $Options = New-PSSessionOption -SkipCACheck -SkipCNCheck
# New-PSSession -ComputerName PS-HOST01 -UseSSL -SessionOption $Options
