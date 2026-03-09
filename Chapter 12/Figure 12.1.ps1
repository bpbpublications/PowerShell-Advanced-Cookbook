# Figure 12.1 - SharePoint Online Web Templates
# Chapter 12: Microsoft 365 with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (SharePoint Online Management Shell)
# Prerequisites: Microsoft.Online.SharePoint.PowerShell module, SharePoint Admin rights

# ============================================================================
# CONNECT TO SHAREPOINT ONLINE
# ============================================================================

# Connect using credential object
# NOTE: Replace with your actual SharePoint admin credentials
$User = "SharePoint@bio-rent.dk"
$Password = "Share@Point2023_Apps123"

# Convert the password to a secure string
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

# Create the PSCredential object
$Credentials = New-Object System.Management.Automation.PSCredential($User, $SecurePassword)

# Connect to SharePoint Online admin center
# The URL must be your tenant's admin URL: https://<tenant>-admin.sharepoint.com
Connect-SPOService -Url https://biorentdk-admin.sharepoint.com -Credential $Credentials

# ============================================================================
# LIST AVAILABLE SITE TEMPLATES
# ============================================================================

# List available SharePoint site design templates using Get-SPOWebTemplate
# LocaleId 1033 = English (United States)
Get-SPOWebTemplate -LocaleId 1033

# Expected Output:
# Name                              Title                                    LocaleId
# ----                              -----                                    --------
# STS#3                            Team site (no Microsoft 365 group)       1033
# GROUP#0                          Team site                                1033
# SITEPAGEPUBLISHING#0             Communication site                       1033
# ...
#
# NOTE: Use these template names when creating new sites with New-SPOSite
