# Figure 12.25 - Microsoft 365 License Information
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
# LIST AVAILABLE LICENSES
# ============================================================================

# List all subscribed SKUs (licenses) in the tenant
Get-MgSubscribedSku |
    Select-Object -Property Sku*, ConsumedUnits -ExpandProperty PrepaidUnits |
    Format-List

# Expected Output:
# SkuId         : xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
# SkuPartNumber : ENTERPRISEPACK
# ConsumedUnits : 10
# Enabled       : 25
# Suspended     : 0
# Warning       : 0
#
# NOTE: ENTERPRISEPACK = Office 365 E3
# ConsumedUnits shows how many licenses are assigned
# Enabled shows total available licenses
