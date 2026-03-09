# Figure 12.24 - Microsoft Graph SDK Connection
# Chapter 12: Microsoft 365 with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (Microsoft.Graph module)
# Prerequisites: Microsoft.Graph module, appropriate Graph API permissions

# ============================================================================
# CONNECT TO MICROSOFT GRAPH - INTERACTIVE
# ============================================================================

# Connect interactively with user and directory read/write permissions
# This opens a browser for authentication
Connect-MgGraph -Scopes "User.ReadWrite.All", "Directory.ReadWrite.All"

# ============================================================================
# CONNECT TO MICROSOFT GRAPH - APP-ONLY (CERTIFICATE)
# ============================================================================

# Connect using certificate-based app-only access
# This is recommended for automation scenarios
$CertificateThumbprint = "<Certificate Thumbprint>"
$ApplicationId = "<Application (Client) ID>"
$TenantId = "<Tenant ID>"

Connect-MgGraph `
    -TenantId $TenantID `
    -ClientId $ApplicationID `
    -CertificateThumbprint $CertificateThumbprint

# ============================================================================
# GET USER INFORMATION
# ============================================================================

# Get user details using Microsoft Graph
Get-MgUser -UserId john@bio-rent.dk

# Expected Output:
# Id                                   DisplayName    UserPrincipalName
# --                                   -----------    -----------------
# xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx John Ambrose   john@bio-rent.dk
#
# NOTE: Microsoft Graph is the unified API for Microsoft 365
# It's replacing Azure AD Graph and other service-specific APIs
