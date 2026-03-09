# Figure 12.16 - Soft-Deleted Mailboxes
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
# SOFT-DELETED MAILBOXES
# ============================================================================

# Try to get a mailbox that has been soft-deleted
# This will return nothing because the mailbox is deleted
Get-Mailbox "john@bio-rent.dk"

# List soft-deleted mailboxes using the -SoftDeletedMailbox parameter
Get-Mailbox "john@bio-rent.dk" -SoftDeletedMailbox

# Expected Output:
# Name           Alias   Database        ProhibitSendQuota
# ----           -----   --------        -----------------
# JohnAmbrose    John    EURPR...        99 GB
#
# NOTE: Soft-deleted mailboxes are retained for 30 days by default
# They can be recovered using Undo-SoftDeletedMailbox or New-MailboxRestoreRequest
