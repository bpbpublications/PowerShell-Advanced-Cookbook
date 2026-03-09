# Figure 12.27 - User License After Assignment
# Chapter 12: Microsoft 365 with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (Microsoft.Graph module)
# Prerequisites: Microsoft.Graph module, appropriate Graph API permissions

# ============================================================================
# CONNECT TO MICROSOFT GRAPH
# ============================================================================

# Connect interactively with user and directory read/write permissions
Connect-MgGraph -Scopes "User.ReadWrite.All", "Directory.ReadWrite.All"

# Or connect using certificate-based app-only access
$CertificateThumbprint = "<Certificate Thumbprint>"
$ApplicationId = "<Application (Client) ID>"
$TenantId = "<Tenant ID>"

Connect-MgGraph `
    -TenantId $TenantID `
    -ClientId $ApplicationID `
    -CertificateThumbprint $CertificateThumbprint

# ============================================================================
# VERIFY LICENSE ASSIGNMENT
# ============================================================================

# List licenses assigned to a user after a license has been assigned
Get-MgUserLicenseDetail -UserId john@bio-rent.dk

# Expected Output (after license assignment):
# Id                                   SkuId                                SkuPartNumber
# --                                   -----                                -------------
# xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy ENTERPRISEPACK
#
# NOTE: To assign a license, use Set-MgUserLicense:
# Set-MgUserLicense -UserId john@bio-rent.dk -AddLicenses @{SkuId = "<SkuId>"} -RemoveLicenses @()
#
# Common SKU Part Numbers:
# - ENTERPRISEPACK: Office 365 E3
# - ENTERPRISEPREMIUM: Office 365 E5
# - SPE_E3: Microsoft 365 E3
# - SPE_E5: Microsoft 365 E5
