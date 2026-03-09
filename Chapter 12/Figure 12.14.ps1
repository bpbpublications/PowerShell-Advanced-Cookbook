# Figure 12.14 - Getting Mailbox by ID
# Chapter 12: Microsoft 365 with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (ExchangeOnlineManagement module)
# Prerequisites: ExchangeOnlineManagement module, Exchange Admin rights

# ============================================================================
# CONNECT TO EXCHANGE ONLINE
# ============================================================================

# Connect to Exchange Online using credentials
$User = "Exchange@bio-rent.dk"
$Password = "ExcOnline@4321"

# Convert the password to a secure string
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

# Create the PSCredential object
$Credentials = New-Object System.Management.Automation.PSCredential($User, $SecurePassword)

# Connect to Exchange Online
Connect-ExchangeOnline -Credential $Credentials

# ============================================================================
# GET MAILBOX BY GUID
# ============================================================================

# View a mailbox using the external directory object ID (GUID)
# This is useful when the email address may have changed
Get-Mailbox df582b3d-ea77-4ccf-a743-2d021f9e4f96 |
    Select-Object Name, DisplayName, WindowsLiveId, WindowsEmailAddress, Id

# Expected Output:
# Name               : JohnAmbrose
# DisplayName        : John Ambrose
# WindowsLiveId      : john@bio-rent.dk
# WindowsEmailAddress: john@bio-rent.dk
# Id                 : df582b3d-ea77-4ccf-a743-2d021f9e4f96
#
# NOTE: The GUID remains constant even if the email address changes
