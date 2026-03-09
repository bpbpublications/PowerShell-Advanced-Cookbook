# Figure 5.13 - Selecting a Code Signing Certificate
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates how to retrieve a specific code signing certificate
# when multiple certificates exist in the store.
#
# Platform: Windows only (Certificate Store)

# ============================================================================
# CREATE SELF-SIGNED CODE SIGNING CERTIFICATE
# ============================================================================

$Dns = "CodeSigning"

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
# SELECT A SPECIFIC CERTIFICATE
# ============================================================================

# When multiple code signing certificates exist, select by index
# [0] gets the first certificate in the collection
$CodeSign = (Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert)[0]
$CodeSign

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# PSParentPath: Microsoft.PowerShell.Security\Certificate::CurrentUser\My
#
# Thumbprint                                Subject
# ----------                                -------
# A1B2C3D4E5F6G7H8I9J0K1L2M3N4O5P6Q7R8S9T0  CN=CodeSigning

# ============================================================================
# ALTERNATIVE SELECTION METHODS
# ============================================================================

# Select by thumbprint (most precise):
# $CodeSign = Get-ChildItem Cert:\CurrentUser\My | Where-Object {
#     $_.Thumbprint -eq "A1B2C3D4E5F6G7H8I9J0K1L2M3N4O5P6Q7R8S9T0"
# }

# Select by subject name:
# $CodeSign = Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert |
#     Where-Object { $_.Subject -eq "CN=CodeSigning" }

# Select by friendly name:
# $CodeSign = Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert |
#     Where-Object { $_.FriendlyName -eq "CodeSigning" }

# Select interactive dialog (GUI):
# $CodeSign = Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert |
#     Out-GridView -Title "Select Certificate" -PassThru

# ============================================================================
# CERTIFICATE PROPERTIES
# ============================================================================

# View all certificate properties:
# $CodeSign | Format-List *

# Common properties:
# $CodeSign.Thumbprint      # Unique identifier
# $CodeSign.Subject         # Certificate subject (CN=...)
# $CodeSign.NotBefore       # Valid from date
# $CodeSign.NotAfter        # Expiration date
# $CodeSign.HasPrivateKey   # True if private key is available

