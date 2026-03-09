# Figure 1.19 - Output of the Current User Personal Certificate Store
# Chapter 1: Introduction to Advanced PowerShell Concepts
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows only

# The Personal certificate store (My) contains certificates where you have
# the associated private key. These are typically used for:
# - Email signing/encryption (S/MIME)
# - Client authentication
# - Code signing
# - Document signing

# List certificates in the Current User's Personal (My) store
Get-ChildItem Cert:\CurrentUser\My

# Basic output may be truncated. Use Format-Table with AutoSize for better display:
Get-ChildItem Cert:\CurrentUser\My | Format-Table -AutoSize

# Expected Output (varies by system):
#    PSParentPath: Microsoft.PowerShell.Security\Certificate::CurrentUser\My
#
# Thumbprint                               Subject                      NotAfter
# ----------                               -------                      --------
# A1B2C3D4E5F6G7H8I9J0K1L2M3N4O5P6Q7R8S9T0 CN=YourCertificate          1/15/2025 12:00:00 AM
# ...

# Check if the Personal store is empty (common on fresh systems)
$personalCerts = Get-ChildItem Cert:\CurrentUser\My -ErrorAction SilentlyContinue
if ($null -eq $personalCerts -or $personalCerts.Count -eq 0) {
    Write-Output "Your Personal certificate store is empty."
    Write-Output "To create a test certificate, see Figure 1.23 (New-SelfSignedCertificate)."
} else {
    Write-Output "Found $($personalCerts.Count) certificate(s) in your Personal store."
}

Write-Output ""
Write-Output "=== Formatting Options for Certificate Display ==="

# Show specific properties in a custom format
Get-ChildItem Cert:\CurrentUser\My |
    Format-Table Thumbprint, Subject, NotAfter, NotBefore -AutoSize

# Show certificates with expiration status
Write-Output ""
Write-Output "=== Certificate Expiration Status ==="
Get-ChildItem Cert:\CurrentUser\My | ForEach-Object {
    $status = if ($_.NotAfter -lt (Get-Date)) { "EXPIRED" } else { "Valid" }
    [PSCustomObject]@{
        Subject   = $_.Subject.Substring(0, [Math]::Min(40, $_.Subject.Length))
        NotAfter  = $_.NotAfter.ToString("yyyy-MM-dd")
        Status    = $status
    }
} | Format-Table -AutoSize

# Alternative: Format as list for detailed view of each certificate
Write-Output ""
Write-Output "=== Detailed List Format ==="
Get-ChildItem Cert:\CurrentUser\My | Select-Object -First 1 |
    Format-List Thumbprint, Subject, Issuer, NotBefore, NotAfter, HasPrivateKey

# Filter certificates by various criteria
Write-Output ""
Write-Output "=== Filtering Examples ==="

# Find certificates expiring within 30 days
$expiringCerts = Get-ChildItem Cert:\CurrentUser\My |
    Where-Object { $_.NotAfter -lt (Get-Date).AddDays(30) -and $_.NotAfter -gt (Get-Date) }
Write-Output "Certificates expiring within 30 days: $($expiringCerts.Count)"

# Find certificates with private keys
$certsWithKeys = Get-ChildItem Cert:\CurrentUser\My |
    Where-Object { $_.HasPrivateKey -eq $true }
Write-Output "Certificates with private keys: $($certsWithKeys.Count)"
