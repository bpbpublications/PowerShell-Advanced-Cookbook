# Figure 12.23 - Listing All Teams
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
# LIST ALL TEAMS
# ============================================================================

# List all Teams in the organization
Get-Team

# Expected Output:
# GroupId                              DisplayName    Visibility  Archived
# -------                              -----------    ----------  --------
# xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx ProjectX       Private     False
# yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy Marketing      Public      False
# zzzzzzzz-zzzz-zzzz-zzzz-zzzzzzzzzzzz IT Support     Private     False
#
# NOTE: Visibility can be Private or Public
# Private teams require invitation, Public teams are discoverable
