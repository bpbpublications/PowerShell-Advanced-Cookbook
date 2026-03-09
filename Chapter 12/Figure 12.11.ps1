# Figure 12.11 - Listing Mailbox Permissions
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
# LIST MAILBOX PERMISSIONS
# ============================================================================

# List full access permissions for a mailbox
Get-MailboxPermission -Identity john@bio-rent.dk

# Expected Output:
# Identity             User                 AccessRights
# --------             ----                 ------------
# John Ambrose         NT AUTHORITY\SELF    {FullAccess, ReadPermission}
#
# NOTE: By default, only the mailbox owner has FullAccess
# Use Add-MailboxPermission to grant access to other users
