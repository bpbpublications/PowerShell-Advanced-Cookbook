# Figure 12.3 - Accessing SharePoint Site in Browser
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
# SITE ACCESS
# ============================================================================

# After creating a site, you can access it in the browser
# Visit the site URL directly:
# https://biorentdk.sharepoint.com/sites/ProjectX

# NOTE: This figure shows a screenshot of the SharePoint site in a browser
# The site can be accessed by users with appropriate permissions
# Site URL format: https://<tenant>.sharepoint.com/sites/<sitename>
