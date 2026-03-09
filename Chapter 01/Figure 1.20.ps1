# Figure 1.20 - Different Methods for Returning a Specific Certificate
# Chapter 1: Introduction to Advanced PowerShell Concepts
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows only

# When working with certificates, you often need to select a specific one.
# There are several methods to do this, each with its own use case.

# First, let's ensure we have certificates to work with
$allCerts = Get-ChildItem Cert:\CurrentUser\My
if ($null -eq $allCerts -or $allCerts.Count -eq 0) {
    Write-Output "No certificates in Personal store. Creating a test certificate..."
    $testCert = New-SelfSignedCertificate -Subject "CN=TestCert-Figure1.20" `
        -DnsName "TestCert-Figure1.20" `
        -CertStoreLocation Cert:\CurrentUser\My
    Write-Output "Test certificate created with thumbprint: $($testCert.Thumbprint)"
    $allCerts = Get-ChildItem Cert:\CurrentUser\My
}

Write-Output "=== Method 1: Select by Index (Array Position) ==="
# Certificates are returned as an array, so you can access by index
# Note: Index starts at 0, order may change as certificates are added/removed
$firstCert = (Get-ChildItem Cert:\CurrentUser\My)[0]
Write-Output "First certificate: $($firstCert.Subject)"

# Using -First parameter (more readable)
$firstCertAlt = Get-ChildItem Cert:\CurrentUser\My | Select-Object -First 1
Write-Output "Same result with Select-Object -First 1"

Write-Output ""
Write-Output "=== Method 2: Select by Thumbprint (Most Reliable) ==="
# Thumbprints are unique identifiers - best for scripting
# First, get a thumbprint to use in our example
$sampleThumbprint = (Get-ChildItem Cert:\CurrentUser\My)[0].Thumbprint
Write-Output "Using thumbprint: $sampleThumbprint"

# Method 2a: Using the path directly
$certByPath = Get-Item -Path "Cert:\CurrentUser\My\$sampleThumbprint"
Write-Output "Found by path: $($certByPath.Subject)"

# Method 2b: Using Where-Object (useful when thumbprint is partial)
$certByWhere = Get-ChildItem Cert:\CurrentUser\My |
    Where-Object { $_.Thumbprint -eq $sampleThumbprint }
Write-Output "Found by Where-Object: $($certByWhere.Subject)"

Write-Output ""
Write-Output "=== Method 3: Select by Subject (CN - Common Name) ==="
# Match certificates by their Subject field
# Useful when you know the certificate name but not the thumbprint

# Example: Find certificates with a specific CN (Common Name)
$certsBySubject = Get-ChildItem Cert:\CurrentUser\My |
    Where-Object { $_.Subject -match "CN=TestCert" }

if ($certsBySubject) {
    Write-Output "Found $($certsBySubject.Count) certificate(s) matching CN=TestCert"
    $certsBySubject | ForEach-Object { Write-Output "  - $($_.Subject)" }
} else {
    Write-Output "No certificates found matching CN=TestCert"
}

# Case-insensitive match
$certsBySubjectCI = Get-ChildItem Cert:\CurrentUser\My |
    Where-Object { $_.Subject -like "*test*" }
Write-Output "Certificates with 'test' in subject (case-insensitive): $($certsBySubjectCI.Count)"

Write-Output ""
Write-Output "=== Method 4: Select by FriendlyName ==="
# FriendlyName is a user-assigned display name (may be empty)
$certsWithFriendlyName = Get-ChildItem Cert:\CurrentUser\My |
    Where-Object { $_.FriendlyName -ne "" }

if ($certsWithFriendlyName) {
    Write-Output "Certificates with FriendlyName set:"
    $certsWithFriendlyName | ForEach-Object {
        Write-Output "  FriendlyName: '$($_.FriendlyName)' -> $($_.Subject)"
    }
} else {
    Write-Output "No certificates have FriendlyName set."
}

# Find by specific FriendlyName
$certByFriendly = Get-ChildItem Cert:\CurrentUser\My |
    Where-Object { $_.FriendlyName -match "TestCert" }

Write-Output ""
Write-Output "=== Method 5: Select by Multiple Criteria ==="
# Combine filters for precise selection
$specificCert = Get-ChildItem Cert:\CurrentUser\My | Where-Object {
    $_.Subject -like "*Test*" -and
    $_.NotAfter -gt (Get-Date) -and
    $_.HasPrivateKey -eq $true
}

if ($specificCert) {
    Write-Output "Found certificate matching all criteria:"
    Write-Output "  Subject: $($specificCert.Subject)"
    Write-Output "  Expires: $($specificCert.NotAfter)"
}

Write-Output ""
Write-Output "=== Summary: When to Use Each Method ==="
Write-Output "Index [0]    : Quick access, but position can change"
Write-Output "Thumbprint   : Most reliable for scripts (unique identifier)"
Write-Output "Subject      : Good when you know the CN/name"
Write-Output "FriendlyName : User-friendly but often empty"
Write-Output "Multiple     : When you need precise matching"

# ============================================================================
# CLEANUP: Remove test certificate (uncomment to run)
# ============================================================================
# Get-ChildItem Cert:\CurrentUser\My |
#     Where-Object { $_.Subject -eq "CN=TestCert-Figure1.20" } |
#     Remove-Item
# Write-Output "Test certificate removed."
