# Figure 12.2 - Listing SharePoint Sites
# Chapter 12: Microsoft 365 with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (SharePoint Online Management Shell)
# Prerequisites: Microsoft.Online.SharePoint.PowerShell module, SharePoint Admin rights

# ============================================================================
# CONNECT TO SHAREPOINT ONLINE
# ============================================================================

# Connect using credential object
$User = "SharePoint@bio-rent.dk"
$Password = "Share@Point2023_Apps123"

# Convert the password to a secure string
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

# Create the PSCredential object
$Credentials = New-Object System.Management.Automation.PSCredential($User, $SecurePassword)

# Connect to SharePoint Online admin center
Connect-SPOService -Url https://biorentdk-admin.sharepoint.com -Credential $Credentials

# ============================================================================
# LIST SHAREPOINT SITES
# ============================================================================

# List all SharePoint sites in the tenant
Get-SPOSite

# List a specific site by identity (URL) with selected properties
Get-SPOSite `
    -Identity https://biorentdk.sharepoint.com/sites/ProjectX |
    Select-Object Title, Url, Owner, StorageQuota, Status

# Expected Output:
# Title       : ProjectX
# Url         : https://biorentdk.sharepoint.com/sites/ProjectX
# Owner       : admin@bio-rent.dk
# StorageQuota: 26214400
# Status      : Active
#
# NOTE: StorageQuota is in MB. 26214400 MB = 25 TB (default)
