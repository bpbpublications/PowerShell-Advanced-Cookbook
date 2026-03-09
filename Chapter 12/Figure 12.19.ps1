# Figure 12.19 - Distribution Group with External Contacts
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
# LIST DISTRIBUTION GROUP WITH EXTERNAL CONTACTS
# ============================================================================

# Get members of a distribution group where mail contacts have been added
Get-DistributionGroupMember External | Select-Object DisplayName, EmailAddresses

# Expected Output:
# DisplayName      EmailAddresses
# -----------      --------------
# Mads Sommer      {SMTP:mads@external.com}
# External Partner {SMTP:partner@external.com}
#
# NOTE: Distribution groups can contain both internal mailboxes and external contacts
# This is useful for communication with external partners or vendors
