# Requires connection to Teams 

# Connect to Teams using a credential object
$User = "Teams@bio-rent.dk"
$Password = "#Team#Manager_Apps123"

# Convert the client secret to a secure string
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

# Create the PSCredential object
$Credentials = New-Object System.Management.Automation.PSCredential($User, $SecurePassword)

# Connect to Microsoft Teams
Connect-MicrosoftTeams -Credential $Credentials


# List all Teams
Get-Team

# List a specific team
Get-Team -DisplayName ProjectX

# Assign group ID for specific team to a variable
$TeamGroupId = (Get-Team -DisplayName ProjectX).GroupId