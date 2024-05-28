
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

#Listing all sites and the new ProjectX site using Get-SPOSite 
Get-SPOSite

# Listing ProjectX site
get-sposite `
-Identity https://biorentdk.sharepoint.com/sites/ProjectX | `
Select-Object Title,Url,Owner,StorageQuota,Status