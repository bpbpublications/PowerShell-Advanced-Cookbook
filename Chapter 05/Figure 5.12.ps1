# Figure 5.12 - Creating a Self-Signed Code Signing Certificate
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates creating a self-signed certificate for code signing.
# Self-signed certificates are useful for development and testing.
#
# Platform: Windows only (Certificate Store)

# ============================================================================
# CREATE SELF-SIGNED CODE SIGNING CERTIFICATE
# ============================================================================

# Certificate parameters
$Dns = "CodeSigning"

# New-SelfSignedCertificate creates a certificate in the Windows certificate store
# Key parameters:
# - KeyUsage DigitalSignature: Allows the cert to be used for signing
# - KeySpec Signature: Marks this as a signature key (not exchange)
# - KeyAlgorithm RSA: Uses RSA encryption algorithm
# - KeyLength 4096: Strong key size for security
# - CertStoreLocation: Where to store the certificate
# - Type CodeSigningCert: Specifically for code signing purposes
$Certificate = New-SelfSignedCertificate `
    -KeyUsage DigitalSignature `
    -KeySpec Signature `
    -KeyAlgorithm RSA `
    -KeyLength 4096 `
    -CertStoreLocation Cert:\CurrentUser\My `
    -Type CodeSigningCert `
    -Subject $Dns `
    -DNSName $Dns `
    -FriendlyName $Dns

# ============================================================================
# VIEW INSTALLED CODE SIGNING CERTIFICATES
# ============================================================================

# List all code signing certificates in the current user's personal store
# -CodeSigningCert filters to only show certificates valid for code signing
Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# PSParentPath: Microsoft.PowerShell.Security\Certificate::CurrentUser\My
#
# Thumbprint                                Subject
# ----------                                -------
# A1B2C3D4E5F6G7H8I9J0K1L2M3N4O5P6Q7R8S9T0  CN=CodeSigning

# ============================================================================
# CERTIFICATE STORE LOCATIONS
# ============================================================================

# CURRENT USER STORES:
# - Cert:\CurrentUser\My        : Personal certificates
# - Cert:\CurrentUser\Root      : Trusted Root CAs
# - Cert:\CurrentUser\CA        : Intermediate CAs

# LOCAL MACHINE STORES (requires elevation):
# - Cert:\LocalMachine\My       : Machine personal certs
# - Cert:\LocalMachine\Root     : Trusted Root CAs
# - Cert:\LocalMachine\CA       : Intermediate CAs

# ============================================================================
# NOTES
# ============================================================================

# - Self-signed certificates are NOT trusted by other systems by default
# - For production, use certificates from a trusted Certificate Authority
# - Certificate validity defaults to 1 year
# - Add -NotAfter parameter to extend: -NotAfter (Get-Date).AddYears(5)

