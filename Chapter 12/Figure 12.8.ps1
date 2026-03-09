# Figure 12.8 - SharePoint Groups After Adding Members
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
# LIST GROUPS WITH MEMBERS
# ============================================================================

# List SharePoint groups and their members after members have been added
Get-SPOSiteGroup `
    -Site https://biorentdk.sharepoint.com/sites/ProjectX |
    Select-Object Title, Users, Roles |
    Format-Table -AutoSize

# Expected Output (after adding members):
# Title                    Users                                      Roles
# -----                    -----                                      -----
# ProjectX Owners          {admin@bio-rent.dk}                        {Full Control}
# ProjectX Members         {john@bio-rent.dk, jane@bio-rent.dk}       {Edit}
# ProjectX Visitors        {guest@bio-rent.dk}                        {Read}
#
# NOTE: Use Add-SPOUser to add users to SharePoint groups
# Add-SPOUser -Site <URL> -LoginName <email> -Group <GroupName>
