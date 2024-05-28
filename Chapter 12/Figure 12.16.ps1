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

# This lists a mailbox after it has been soft-deleted

Get-Mailbox "john@bio-rent.dk"

Get-Mailbox "john@bio-rent.dk" -SoftDeletedMailbox