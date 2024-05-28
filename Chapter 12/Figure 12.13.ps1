# Requires connection to Exchange Online

# Connect to Exchange Online using credentials
$User = "Exchange@bio-rent.dk"
$Password = "ExcOnline@4321"

# Convert the client secret to a secure string
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

# Create the PSCredential object
$Credentials = New-Object System.Management.Automation.PSCredential($User, $SecurePassword)

# Connect
Connect-ExchangeOnline -Credential $Credentials

# # Forward emails and keep a copy in the original mailbox
# Set-Mailbox -Identity "john@bio-rent.dk" `
# -ForwardingAddress "morten@bio-rent.dk" `
# -DeliverToMailboxAndForward $true

# View who a mailbox is forwarded too
Get-Mailbox "john@bio-rent.dk" | `
Select-Object ForwardingAddress,ForwardingSmtpAddress,DeliverToMailboxAndForward