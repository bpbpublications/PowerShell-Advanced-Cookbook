# Figure 12.21 - Microsoft Teams Users
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
# LIST TEAM MEMBERS
# ============================================================================

# Assign group ID for specific team to a variable
$TeamGroupId = (Get-Team -DisplayName ProjectX).GroupId

# List all team members
Get-TeamUser -GroupId $TeamGroupId

# Expected Output:
# UserId                               User                    Name         Role
# ------                               ----                    ----         ----
# xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx admin@bio-rent.dk       Admin User   owner
# xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx john@bio-rent.dk        John Doe     member
#
# NOTE: Roles can be: owner, member, or guest
# Use Add-TeamUser and Remove-TeamUser to manage membership
