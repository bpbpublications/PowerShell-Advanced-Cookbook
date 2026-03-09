# Figure 1.18 - The CurrentUser Certificate Store Structure
# Chapter 1: Introduction to Advanced PowerShell Concepts
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows only

# The Certificate provider (Cert:) allows you to browse and manage X.509
# certificates stored on your Windows system, just like navigating a filesystem.

# Certificate stores are organized into two main locations:
# - CurrentUser (Cert:\CurrentUser) - Certificates for the logged-in user
# - LocalMachine (Cert:\LocalMachine) - System-wide certificates (requires elevation)

# List all certificate store folders for the current user
Get-ChildItem Cert:\CurrentUser

# Expected Output:
# Name : ACRS
# Name : CA
# Name : ClientAuthIssuer
# Name : Disallowed
# Name : FlightRoot
# Name : MSIEHistoryJournal
# Name : My
# Name : Root
# Name : SmartCardRoot
# Name : Trust
# Name : TrustedPeople
# Name : TrustedPublisher
# Name : UserDS

# Understanding the common certificate stores:
Write-Output ""
Write-Output "=== Common Certificate Store Folders ==="
Write-Output ""

# Display store information in a readable format
$stores = @{
    "My"               = "Personal certificates (your certificates with private keys)"
    "Root"             = "Trusted Root Certification Authorities"
    "CA"               = "Intermediate Certification Authorities"
    "TrustedPublisher" = "Trusted Publishers (for code signing)"
    "TrustedPeople"    = "Trusted People (for EFS and similar)"
    "Disallowed"       = "Untrusted/revoked certificates"
}

foreach ($store in $stores.GetEnumerator()) {
    Write-Output "$($store.Key): $($store.Value)"
}

Write-Output ""
Write-Output "=== Store name mapping (Console vs PowerShell) ==="
Write-Output "Windows Certificate Manager    PowerShell Cert:\CurrentUser\"
Write-Output "------------------------       -----------------------"
Write-Output "Personal                   ->  My"
Write-Output "Trusted Root CAs           ->  Root"
Write-Output "Intermediate CAs           ->  CA"
Write-Output "Trusted Publishers         ->  TrustedPublisher"

# Count certificates in each store
Write-Output ""
Write-Output "=== Certificate count per store ==="
Get-ChildItem Cert:\CurrentUser | ForEach-Object {
    $certCount = (Get-ChildItem "Cert:\CurrentUser\$($_.Name)" -ErrorAction SilentlyContinue).Count
    Write-Output "$($_.Name): $certCount certificate(s)"
}

# Compare with LocalMachine store (requires elevation for some operations)
Write-Output ""
Write-Output "=== LocalMachine store folders ==="
Get-ChildItem Cert:\LocalMachine | Select-Object Name

# Tip: The LocalMachine store contains system-wide certificates and typically
# has more entries in Root and CA stores than the CurrentUser store.
# Modifying LocalMachine requires running PowerShell as Administrator.
