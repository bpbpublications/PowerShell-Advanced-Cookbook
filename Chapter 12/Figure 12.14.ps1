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

# View a mailbox using the ID
Get-Mailbox df582b3d-ea77-4ccf-a743-2d021f9e4f96 | `
Select-Object Name,DisaplyName,WindowsLiveId,WindowsEmailAddress,Id