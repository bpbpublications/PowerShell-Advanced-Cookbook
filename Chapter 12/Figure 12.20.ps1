# Figure 12.20 - Microsoft Teams Management
# Chapter 12: Microsoft 365 with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (MicrosoftTeams module)
# Prerequisites: MicrosoftTeams module, Teams Admin rights

# ============================================================================
# CONNECT TO MICROSOFT TEAMS
# ============================================================================

# Connect to Teams using a credential object
$User = "Teams@bio-rent.dk"
$Password = "#Team#Manager_Apps123"

# Convert the password to a secure string
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

# Create the PSCredential object
$Credentials = New-Object System.Management.Automation.PSCredential($User, $SecurePassword)

# Connect to Microsoft Teams
Connect-MicrosoftTeams -Credential $Credentials

# ============================================================================
# LIST TEAMS
# ============================================================================

# List all Teams in the organization
Get-Team

# List a specific team by display name
Get-Team -DisplayName ProjectX

# Assign group ID for specific team to a variable for further operations
$TeamGroupId = (Get-Team -DisplayName ProjectX).GroupId

# Expected Output:
# GroupId                              DisplayName  Visibility  Archived  MailNickName
# -------                              -----------  ----------  --------  ------------
# xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx ProjectX     Private     False     ProjectX
#
# NOTE: Each Team has a unique GroupId (Microsoft 365 Group ID)
# This ID is used for most team management operations
