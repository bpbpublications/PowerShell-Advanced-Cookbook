# Figure 12.9 - Exchange Online Module and Connection
# Chapter 12: Microsoft 365 with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (ExchangeOnlineManagement module)
# Prerequisites: ExchangeOnlineManagement module, Exchange Admin rights

# ============================================================================
# BEFORE CONNECTING - MODULE NOT LOADED
# ============================================================================

# Trying to use the (Non-existing) Get-MailBox cmdlet before connecting
# This will fail because the cmdlet doesn't exist until connected
Get-Mailbox

# Trying to use the (Module-existing) Get-EXOMailBox cmdlet
# This is the modern cmdlet but still requires connection
Get-EXOMailbox

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
# This imports additional cmdlets via implicit remoting
Connect-ExchangeOnline -Credential $Credentials

# ============================================================================
# AFTER CONNECTING - CMDLETS AVAILABLE
# ============================================================================

# List a specific (existing) mailbox
Get-Mailbox -Identity Hostmaster

# Verify where the Get-Mailbox cmdlet comes from
Get-Command Get-Mailbox

# List all cmdlets from the Exchange Online session module
# Note: The module name changes each session (e.g., tmpEXO_beufp25s.wox)
Get-Command -Module tmpEXO_beufp25s.wox

# NOTE: The module name returned from Get-Command Get-Mailbox should be used
# Exchange Online uses implicit remoting to import cmdlets dynamically
