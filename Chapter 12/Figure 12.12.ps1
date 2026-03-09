# Figure 12.12 - Mailbox Permissions After Granting Access
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
# LIST PERMISSIONS AFTER GRANTING ACCESS
# ============================================================================

# List full access permissions for a mailbox after another user has been granted access
Get-MailboxPermission -Identity john@bio-rent.dk

# Expected Output (after granting access):
# Identity             User                      AccessRights
# --------             ----                      ------------
# John Ambrose         NT AUTHORITY\SELF         {FullAccess, ReadPermission}
# John Ambrose         morten@bio-rent.dk        {FullAccess}
#
# NOTE: To grant full access to another user:
# Add-MailboxPermission -Identity john@bio-rent.dk -User morten@bio-rent.dk -AccessRights FullAccess
