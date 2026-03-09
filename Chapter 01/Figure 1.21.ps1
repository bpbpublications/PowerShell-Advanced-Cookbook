# Figure 1.21 - All the Certificate Properties
# Chapter 1: Introduction to Advanced PowerShell Concepts
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows only

# X.509 certificates contain many properties that describe the certificate's
# purpose, validity, issuer, and more. Understanding these properties is
# essential for certificate management and security.

# Ensure we have a certificate to examine
$allCerts = Get-ChildItem Cert:\CurrentUser\My -ErrorAction SilentlyContinue
if ($null -eq $allCerts -or $allCerts.Count -eq 0) {
    Write-Output "Creating a test certificate for demonstration..."
    New-SelfSignedCertificate -Subject "CN=TestCert-Figure1.21" `
        -DnsName "TestCert-Figure1.21" `
        -FriendlyName "Test Certificate for Figure 1.21" `
        -CertStoreLocation Cert:\CurrentUser\My | Out-Null
}

# Select a certificate to examine
$Cert = (Get-ChildItem Cert:\CurrentUser\My)[0]

Write-Output "=== Examining Certificate: $($Cert.Subject) ==="
Write-Output ""

# View ALL properties using Select-Object *
$Cert | Select-Object *

# Expected Output includes properties like:
# PSPath            : Microsoft.PowerShell.Security\Certificate::CurrentUser\My\ABC123...
# PSParentPath      : Microsoft.PowerShell.Security\Certificate::CurrentUser\My
# PSChildName       : ABC123DEF456... (thumbprint)
# PSDrive           : Cert
# PSProvider        : Microsoft.PowerShell.Security\Certificate
# PSIsContainer     : False
# Archived          : False
# Extensions        : {System.Security.Cryptography.Oid, ...}
# FriendlyName      : Test Certificate
# IssuerName        : System.Security.Cryptography.X509Certificates.X500DistinguishedName
# NotAfter          : 1/15/2026 12:00:00 AM
# NotBefore         : 1/15/2025 12:00:00 AM
# HasPrivateKey     : True
# PrivateKey        : System.Security.Cryptography.RSACryptoServiceProvider
# PublicKey         : System.Security.Cryptography.X509Certificates.PublicKey
# RawData           : {48, 130, 3, 123...}
# SerialNumber      : 1234567890ABCDEF
# SubjectName       : System.Security.Cryptography.X509Certificates.X500DistinguishedName
# SignatureAlgorithm: System.Security.Cryptography.Oid
# Thumbprint        : ABC123DEF456...
# Version           : 3
# Handle            : 1234567890
# Issuer            : CN=TestCert
# Subject           : CN=TestCert

Write-Output ""
Write-Output "=== Key Properties Explained ==="

# Important properties for common tasks
$propertyInfo = @(
    @{ Name = "Thumbprint"; Value = $Cert.Thumbprint; Desc = "Unique identifier (SHA-1 hash)" }
    @{ Name = "Subject"; Value = $Cert.Subject; Desc = "Who the cert is issued to" }
    @{ Name = "Issuer"; Value = $Cert.Issuer; Desc = "Who issued the certificate" }
    @{ Name = "NotBefore"; Value = $Cert.NotBefore; Desc = "Valid from this date" }
    @{ Name = "NotAfter"; Value = $Cert.NotAfter; Desc = "Expires on this date" }
    @{ Name = "HasPrivateKey"; Value = $Cert.HasPrivateKey; Desc = "True if private key is available" }
    @{ Name = "SerialNumber"; Value = $Cert.SerialNumber; Desc = "Unique serial from issuer" }
    @{ Name = "Version"; Value = $Cert.Version; Desc = "X.509 version (usually 3)" }
)

$propertyInfo | ForEach-Object {
    Write-Output "$($_.Name): $($_.Value)"
    Write-Output "  -> $($_.Desc)"
    Write-Output ""
}

Write-Output "=== Provider Metadata Properties (PS*) ==="
Write-Output "PSDrive   : $($Cert.PSDrive) - The PowerShell drive"
Write-Output "PSProvider: $($Cert.PSProvider) - Certificate provider"
Write-Output "PSPath    : $($Cert.PSPath.Substring(0, [Math]::Min(60, $Cert.PSPath.Length)))..."

Write-Output ""
Write-Output "=== Certificate Extensions ==="
# Extensions contain additional information like Key Usage, Enhanced Key Usage
if ($Cert.Extensions.Count -gt 0) {
    $Cert.Extensions | ForEach-Object {
        Write-Output "Extension: $($_.Oid.FriendlyName) ($($_.Oid.Value))"
    }
} else {
    Write-Output "No extensions found."
}

Write-Output ""
Write-Output "=== Practical Examples ==="

# Check if certificate is expired
$isExpired = $Cert.NotAfter -lt (Get-Date)
Write-Output "Is Expired: $isExpired"

# Days until expiration
$daysUntilExpiry = ($Cert.NotAfter - (Get-Date)).Days
Write-Output "Days until expiry: $daysUntilExpiry"

# Check if self-signed (issuer equals subject)
$isSelfSigned = $Cert.Issuer -eq $Cert.Subject
Write-Output "Is Self-Signed: $isSelfSigned"

# ============================================================================
# CLEANUP: Remove test certificate (uncomment to run)
# ============================================================================
# Get-ChildItem Cert:\CurrentUser\My |
#     Where-Object { $_.Subject -eq "CN=TestCert-Figure1.21" } |
#     Remove-Item
# Write-Output "Test certificate removed."
