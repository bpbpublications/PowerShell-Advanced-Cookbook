# Figure 12.18 - Mail Contacts
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
# LIST MAIL CONTACTS
# ============================================================================

# List all mail contacts in the organization
Get-MailContact |
    Select-Object DisplayName, Name, ExternalEmailAddress

# List a specific mail contact by identity
Get-MailContact `
    -Identity "MadsSommer" |
    Select-Object DisplayName, Name, ExternalEmailAddress

# Expected Output:
# DisplayName      Name           ExternalEmailAddress
# -----------      ----           --------------------
# Mads Sommer      MadsSommer     SMTP:mads@external.com
#
# NOTE: Mail contacts represent external email addresses in the global address list
# Use New-MailContact to create new contacts
