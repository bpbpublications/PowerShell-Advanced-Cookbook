# Figure 12.13 - Mailbox Forwarding Settings
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
# CONFIGURE EMAIL FORWARDING
# ============================================================================

# Forward emails and keep a copy in the original mailbox
# Set-Mailbox -Identity "john@bio-rent.dk" `
#     -ForwardingAddress "morten@bio-rent.dk" `
#     -DeliverToMailboxAndForward $true

# ============================================================================
# VIEW FORWARDING SETTINGS
# ============================================================================

# View who a mailbox is forwarded to
Get-Mailbox "john@bio-rent.dk" |
    Select-Object ForwardingAddress, ForwardingSmtpAddress, DeliverToMailboxAndForward

# Expected Output:
# ForwardingAddress              ForwardingSmtpAddress  DeliverToMailboxAndForward
# -----------------              ---------------------  --------------------------
# morten@bio-rent.dk                                    True
#
# NOTE: DeliverToMailboxAndForward = True means emails are delivered to both mailboxes
# If False, emails are only sent to the forwarding address
