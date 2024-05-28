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


# Listing SharePoint groups and their members after members have been added to the groups
Get-SPOSiteGroup `
-Site  https://biorentdk.sharepoint.com/sites/ProjectX | `
Select-Object Title,Users,Roles | `
Format-Table -AutoSize