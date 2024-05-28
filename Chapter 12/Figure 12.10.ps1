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

# Create a new Mailbox
New-Mailbox `
-MicrosoftOnlineServicesID "John@bio-rent.dk" `
-Alias John `
-Name JohnAmbrose `
-FirstName John `
-LastName Ambrose `
-DisplayName "John Ambrose" `
-Password (ConvertTo-SecureString -String "ThisIs#VerySecret2468" -AsPlainText -Force) `
-ResetPasswordOnNextLogon $true