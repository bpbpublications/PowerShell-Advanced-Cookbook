# Figure 12.6 - Site Users After Removing Special Accounts
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

# List site users after removal of special accounts
# (e.g., "Everyone" or "Everyone except external users")
Get-SPOUser `
    -Site https://biorentdk.sharepoint.com/sites/ProjectX

# Expected Output:
# After removing special groups, only explicitly added users remain
# This provides better security by requiring explicit permission grants
