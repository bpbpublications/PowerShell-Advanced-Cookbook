# Figure 5.14 - Viewing Certificates in Certificate Manager
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates creating a code signing certificate and viewing it
# using the Windows Certificate Manager GUI tool.
#
# Platform: Windows only (Certificate Store and GUI)

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
# VIEW IN CERTIFICATE MANAGER
# ============================================================================

# To open the Windows Certificate Manager GUI:
# - Run: certmgr.msc
# - Or from PowerShell: Start-Process certmgr.msc
#
# Navigate to: Personal > Certificates
# The code signing certificate will appear there

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# In the Certificate Manager GUI, you will see:
# - Issued To: CodeSigning
# - Issued By: CodeSigning (self-signed)
# - Expiration Date: (one year from creation)
# - Intended Purposes: Code Signing
# - Friendly Name: CodeSigning

# ============================================================================
# CERTIFICATE MANAGER COMMANDS
# ============================================================================

# Open Current User certificate store:
# Start-Process certmgr.msc

# Open Local Machine certificate store (requires elevation):
# Start-Process certlm.msc

# View certificate details in PowerShell:
# $CodeSign | Format-List *

# Export certificate to file (without private key):
# Export-Certificate -Cert $CodeSign -FilePath "CodeSigning.cer"

# Export certificate with private key (PFX):
# $Password = ConvertTo-SecureString -String "MyPassword" -Force -AsPlainText
# Export-PfxCertificate -Cert $CodeSign -FilePath "CodeSigning.pfx" -Password $Password

