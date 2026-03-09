# Figure 1.22 - Remove a Certificate from the Current User Personal Store
# Chapter 1: Introduction to Advanced PowerShell Concepts
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows only

# Removing certificates is a common maintenance task. You might need to remove
# expired certificates, revoked certificates, or clean up test certificates.

# WARNING: Removing certificates can affect system functionality and security.
# - Applications may fail if they depend on a removed certificate
# - You cannot recover a removed certificate unless you have a backup (.pfx export)
# - Removing from LocalMachine requires administrator privileges

# ============================================================================
# SETUP: Create a test certificate that we'll remove
# ============================================================================

Write-Output "=== Creating a test certificate for removal demonstration ==="

# Create a test certificate specifically for this demo
$TestCertName = "TestCert-ToBeRemoved"
$testCert = New-SelfSignedCertificate -Subject "CN=$TestCertName" `
    -DnsName $TestCertName `
    -FriendlyName "Test Certificate - Safe to Remove" `
    -CertStoreLocation Cert:\CurrentUser\My

Write-Output "Created test certificate:"
Write-Output "  Subject: $($testCert.Subject)"
Write-Output "  Thumbprint: $($testCert.Thumbprint)"

# Verify it exists
Write-Output ""
Write-Output "=== Before removal - Certificate exists ==="
Get-ChildItem Cert:\CurrentUser\My | Where-Object { $_.Subject -eq "CN=$TestCertName" } |
    Format-Table Subject, Thumbprint -AutoSize

# ============================================================================
# DEMONSTRATION: Safe removal practices
# ============================================================================

Write-Output ""
Write-Output "=== Method 1: Using -WhatIf to preview removal ==="
# Always preview destructive operations first
$Cert = Get-ChildItem Cert:\CurrentUser\My |
    Where-Object { $_.Subject -eq "CN=$TestCertName" }
$Cert | Remove-Item -WhatIf

# Expected Output:
# What if: Performing the operation "Remove certificate" on target "CN=TestCert-ToBeRemoved".

Write-Output ""
Write-Output "=== Method 2: Using -Confirm for interactive confirmation ==="
# Uncomment to test interactive confirmation:
# $Cert | Remove-Item -Confirm

Write-Output ""
Write-Output "=== Method 3: Remove by piping from Get-ChildItem ==="
# Select the certificate and pipe to Remove-Item

# Store reference before removal for verification
$thumbprintToRemove = $Cert.Thumbprint

# Perform the removal
$Cert | Remove-Item

# Verify removal
Write-Output ""
Write-Output "=== After removal - Verification ==="
$remainingCert = Get-ChildItem Cert:\CurrentUser\My |
    Where-Object { $_.Thumbprint -eq $thumbprintToRemove }

if ($null -eq $remainingCert) {
    Write-Output "SUCCESS: Certificate has been removed."
} else {
    Write-Output "WARNING: Certificate still exists."
}

# Show current state of the store
Write-Output ""
Write-Output "=== Current Personal store contents ==="
Get-ChildItem Cert:\CurrentUser\My | Format-Table Subject, NotAfter -AutoSize

# ============================================================================
# Alternative removal methods
# ============================================================================

Write-Output ""
Write-Output "=== Alternative Removal Methods ==="

# Method A: Remove by thumbprint path (if you know the thumbprint)
# Remove-Item -Path "Cert:\CurrentUser\My\ABC123DEF456..."

# Method B: Remove all expired certificates
Write-Output "Finding expired certificates (not removing, just showing):"
$expiredCerts = Get-ChildItem Cert:\CurrentUser\My |
    Where-Object { $_.NotAfter -lt (Get-Date) }
Write-Output "Found $($expiredCerts.Count) expired certificate(s)"

# To remove all expired (DANGEROUS - uncomment only if you're sure):
# $expiredCerts | Remove-Item

# Method C: Remove by subject pattern
# Get-ChildItem Cert:\CurrentUser\My |
#     Where-Object { $_.Subject -like "*TestCert*" } |
#     Remove-Item

Write-Output ""
Write-Output "=== Important Notes ==="
Write-Output "- Use -WhatIf to preview before actual removal"
Write-Output "- Export certificates to .pfx before removing if backup needed"
Write-Output "- LocalMachine store requires running as Administrator"
Write-Output "- Some certificates are protected and cannot be removed"
