# Figure 12.10 - Creating a New Exchange Online Mailbox
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
# CREATE NEW MAILBOX
# ============================================================================

# Create a new mailbox with all user details
New-Mailbox `
    -MicrosoftOnlineServicesID "John@bio-rent.dk" `
    -Alias John `
    -Name JohnAmbrose `
    -FirstName John `
    -LastName Ambrose `
    -DisplayName "John Ambrose" `
    -Password (ConvertTo-SecureString -String "ThisIs#VerySecret2468" -AsPlainText -Force) `
    -ResetPasswordOnNextLogon $true

# Expected Output:
# Name        Alias   Database        ProhibitSendQuota   ExternalDirectoryObjectId
# ----        -----   --------        -----------------   -------------------------
# JohnAmbrose John    EURPR...        99 GB               xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
#
# NOTE: This creates both a user account and mailbox in Microsoft 365
# The -ResetPasswordOnNextLogon forces the user to change password on first login
