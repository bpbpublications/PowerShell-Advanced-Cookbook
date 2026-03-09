# Figure 1.23 - Create a New Self-Signed Certificate in the Current User Personal Store
# Chapter 1: Introduction to Advanced PowerShell Concepts
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows only

# Self-signed certificates are useful for development, testing, and internal use.
# They are NOT trusted by default and should NOT be used for production public services.

# Common use cases for self-signed certificates:
# - Local development (HTTPS for localhost)
# - Testing certificate-based authentication
# - Internal services in trusted environments
# - Code signing for internal scripts
# - Encryption for internal data

# ============================================================================
# Basic Self-Signed Certificate
# ============================================================================

Write-Output "=== Creating a Basic Self-Signed Certificate ==="

$Name = "TestCert-CurrentUser"
$basicCert = New-SelfSignedCertificate `
    -Subject "CN=$Name" `
    -DnsName $Name `
    -FriendlyName $Name `
    -CertStoreLocation Cert:\CurrentUser\My

Write-Output "Certificate created:"
Write-Output "  Subject: $($basicCert.Subject)"
Write-Output "  Thumbprint: $($basicCert.Thumbprint)"
Write-Output "  Valid Until: $($basicCert.NotAfter)"

# Expected Output:
#    PSParentPath: Microsoft.PowerShell.Security\Certificate::CurrentUser\My
#
# Thumbprint                               Subject
# ----------                               -------
# ABC123DEF456...                          CN=TestCert-CurrentUser

# ============================================================================
# Advanced Certificate Options
# ============================================================================

Write-Output ""
Write-Output "=== Creating Certificate with Extended Options ==="

# Certificate for server authentication (HTTPS)
$serverCert = New-SelfSignedCertificate `
    -Subject "CN=myserver.local" `
    -DnsName "myserver.local", "localhost", "127.0.0.1" `
    -FriendlyName "My Local Server Certificate" `
    -CertStoreLocation Cert:\CurrentUser\My `
    -KeyAlgorithm RSA `
    -KeyLength 2048 `
    -NotAfter (Get-Date).AddYears(2) `
    -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.1")

Write-Output "Server certificate created:"
Write-Output "  DNS Names: myserver.local, localhost, 127.0.0.1"
Write-Output "  Valid for: 2 years"

Write-Output ""
Write-Output "=== Creating Code Signing Certificate ==="

# Certificate for signing PowerShell scripts
$codeSigningCert = New-SelfSignedCertificate `
    -Subject "CN=PowerShell Code Signing" `
    -FriendlyName "My Code Signing Certificate" `
    -CertStoreLocation Cert:\CurrentUser\My `
    -Type CodeSigningCert `
    -NotAfter (Get-Date).AddYears(5)

Write-Output "Code signing certificate created:"
Write-Output "  Type: Code Signing"
Write-Output "  Valid for: 5 years"

# ============================================================================
# Certificate Parameters Explained
# ============================================================================

Write-Output ""
Write-Output "=== Common New-SelfSignedCertificate Parameters ==="
$params = @"
-Subject        : The certificate subject (CN=CommonName, O=Org, etc.)
-DnsName        : DNS names for Subject Alternative Names (SAN)
-FriendlyName   : User-friendly display name
-CertStoreLocation : Where to store (Cert:\CurrentUser\My or Cert:\LocalMachine\My)
-KeyAlgorithm   : RSA (default) or ECDSA
-KeyLength      : 2048, 4096 for RSA; 256, 384, 521 for ECDSA
-NotAfter       : Expiration date (default: 1 year)
-NotBefore      : Start date (default: now)
-Type           : Custom, CodeSigningCert, DocumentEncryptionCert, etc.
-KeyUsage       : KeyEncipherment, DataEncipherment, DigitalSignature, etc.
-TextExtension  : Add custom OID extensions
"@
Write-Output $params

# ============================================================================
# View Created Certificates
# ============================================================================

Write-Output ""
Write-Output "=== All Test Certificates Created ==="
Get-ChildItem Cert:\CurrentUser\My |
    Where-Object { $_.Subject -like "*TestCert*" -or $_.Subject -like "*myserver*" -or $_.Subject -like "*Code Signing*" } |
    Format-Table Subject, NotAfter, Thumbprint -AutoSize

# ============================================================================
# CLEANUP: Remove test certificates (uncomment to run)
# ============================================================================
# Write-Output ""
# Write-Output "=== Cleaning up test certificates ==="
# Get-ChildItem Cert:\CurrentUser\My |
#     Where-Object {
#         $_.Subject -eq "CN=TestCert-CurrentUser" -or
#         $_.Subject -eq "CN=myserver.local" -or
#         $_.Subject -eq "CN=PowerShell Code Signing"
#     } |
#     Remove-Item
# Write-Output "Test certificates removed."
