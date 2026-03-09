# Figure 12.7 - Listing SharePoint Site Groups
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
# LIST SITE GROUPS
# ============================================================================

# List site-specific SharePoint groups with their members and roles
Get-SPOSiteGroup `
    -Site https://biorentdk.sharepoint.com/sites/ProjectX |
    Select-Object Title, Users, Roles |
    Format-Table -AutoSize

# Expected Output:
# Title                    Users                              Roles
# -----                    -----                              -----
# ProjectX Owners          {admin@bio-rent.dk}                {Full Control}
# ProjectX Members         {}                                 {Edit}
# ProjectX Visitors        {}                                 {Read}
#
# NOTE: Each SharePoint site has default groups: Owners, Members, Visitors
# These correspond to Full Control, Edit, and Read permissions
