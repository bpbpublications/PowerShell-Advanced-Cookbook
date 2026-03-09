# Figure 12.4 - Listing SharePoint Site Users
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
# LIST SITE USERS
# ============================================================================

# List all users with access to a specific SharePoint site
Get-SPOUser `
    -Site https://biorentdk.sharepoint.com/sites/ProjectX

# Expected Output:
# DisplayName          LoginName                                    IsSiteAdmin
# -----------          ---------                                    -----------
# Admin User           i:0#.f|membership|admin@bio-rent.dk          True
# John Doe             i:0#.f|membership|john@bio-rent.dk           False
# ...
#
# NOTE: LoginName uses claims-based identity format
# i:0#.f|membership| indicates a forms-based membership provider
