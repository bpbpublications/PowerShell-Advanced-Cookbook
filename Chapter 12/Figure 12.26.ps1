# Figure 12.26 - User License Details
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
# LIST USER LICENSE DETAILS
# ============================================================================

# List licenses assigned to specific users
Get-MgUserLicenseDetail -UserId morten@bio-rent.dk
Get-MgUserLicenseDetail -UserId john@bio-rent.dk

# Expected Output:
# Id                                   SkuId                                SkuPartNumber
# --                                   -----                                -------------
# xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy ENTERPRISEPACK
#
# NOTE: A user can have multiple licenses assigned
# Use Set-MgUserLicense to assign or remove licenses
