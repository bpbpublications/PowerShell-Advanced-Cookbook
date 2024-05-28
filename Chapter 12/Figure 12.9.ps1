# This is executed before connecting to Exchange online

# Trying to use the (Non-existing) Get-MailBox cmdlet
Get-Mailbox

# Trying to use the (Module-existing) Get-EXOMailBox cmdlet
Get-EXOMailbox

# Connect to Exchange Online using credentials
$User = "Exchange@bio-rent.dk"
$Password = "ExcOnline@4321"

# Convert the client secret to a secure string
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

# Create the PSCredential object
$Credentials = New-Object System.Management.Automation.PSCredential($User, $SecurePassword)

# Connect
Connect-ExchangeOnline -Credential $Credentials

# This requires you to be connectet to Exchange online

# Listing specific (existing) mailbox
Get-Mailbox -Identity Hostmaster

# Get-Command
Get-Command Get-Mailbox

# Get-Command -Module for Exchange session imported module
Get-Command -Module tmpEXO_beufp25s.wox
# Note this changes and should be the module returned from the previous command: Get-Command Get-Mailbox