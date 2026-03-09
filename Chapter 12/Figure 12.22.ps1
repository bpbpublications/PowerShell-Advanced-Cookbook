# Figure 12.22 - Microsoft Teams Channels
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
# LIST TEAM CHANNELS
# ============================================================================

# Assign group ID for specific team to a variable
$TeamGroupId = (Get-Team -DisplayName ProjectX).GroupId

# List all channels in the team
Get-TeamChannel -GroupId $TeamGroupId

# Expected Output:
# Id                                   DisplayName       MembershipType
# --                                   -----------       --------------
# 19:xxxxxxxx@thread.tacv2             General           Standard
# 19:yyyyyyyy@thread.tacv2             Development       Standard
# 19:zzzzzzzz@thread.tacv2             Marketing         Private
#
# NOTE: MembershipType can be: Standard (visible to all) or Private (restricted)
# Use New-TeamChannel to create new channels
