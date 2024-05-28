# Requires connection to Sharepoint Online

# Connect using credential object
$User = "SharePoint@bio-rent.dk"
$Password = "Share@Point2023_Apps123"

# Convert the client secret to a secure string
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

# Create the PSCredential object
$Credentials = New-Object System.Management.Automation.PSCredential($User, $SecurePassword)

# Connect
Connect-SPOService -Url https://biorentdk-admin.sharepoint.com -Credential $Credentials

# Listing available SharePoint site design templates using Get-SPOWebTemplate

Get-SPOWebTemplate -LocaleId 1033