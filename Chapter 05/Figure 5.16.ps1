# Figure 5.16 - Signing a Script with Set-AuthenticodeSignature
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates the complete process of creating a code signing
# certificate and using it to sign a PowerShell script.
#
# Platform: Windows only

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
# SELECT THE CERTIFICATE
# ============================================================================

$CodeSign = (Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert)[0]
$CodeSign

# ============================================================================
# SIGN A SCRIPT
# ============================================================================

# Script to sign (save the following to a file first):
# # I need to sign this script!
# Write-Output "I need to sign this script!"

# Set-AuthenticodeSignature adds a digital signature to the script
# -FilePath: Path to the script file to sign
# -Certificate: The code signing certificate to use
#Set-AuthenticodeSignature -FilePath <PathToScript> -Certificate $CodeSign

# ============================================================================
# EXPECTED OUTPUT (after signing)
# ============================================================================

# Directory: C:\Temp
#
# SignerCertificate                         Status   Path
# -----------------                         ------   ----
# A1B2C3D4E5F6...                           Valid    Script.ps1

# ============================================================================
# SIGNATURE VERIFICATION
# ============================================================================

# Verify a script's signature:
# Get-AuthenticodeSignature -FilePath <PathToScript>
#
# Status values:
# - Valid: Signature is valid and certificate is trusted
# - NotSigned: Script has no signature
# - HashMismatch: Script was modified after signing
# - UnknownError: Certificate not trusted or other issue

# ============================================================================
# IMPORTANT NOTES
# ============================================================================

# - The script file must be saved to disk before signing
# - Signing adds a signature block at the end of the script
# - Any modification to the script invalidates the signature
# - Self-signed certificates show "UnknownError" on other machines
# - For trusted signatures, use a certificate from a CA

