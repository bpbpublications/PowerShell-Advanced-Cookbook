# Read XML file using accelerator
[xml]$Config = Get-Content C:\Temp\Config3.xml

# View the type and members
$Config | Get-Member

# View Section (Database)
$Config.Config.Database

# View Section (Azure)
$Config.Config.Azure

# View Section (ServiceAccount)
$Config.Config.ServiceAccount

# Assign individual settings to variables
$DBInstance = $Config.Config.Database.Instance
$DBInstance
$DBPort = $Config.Config.Database.Port
$DBPort
$DBName = $Config.Config.Database.Database
$DBName

# Example of using extracted XML data
$AzureSub = $Config.Config.Azure.SubscriptionId
$AzureTen = $Config.Config.Azure.TenantId
$SaName = $Config.Config.ServiceAccount.UserName

Write-Output "Azure information:
    Subscription: $AzureSub
    Tenant: $AzureTen
"

Write-Output "Database information:
    Instance: $($Config.Config.Database.Instance)
    Port: $($Config.Config.Database.Port)
    Database: $($Config.Config.Database.Database)
"
Write-Output "ServiceAccount:
    UserName: $SaName
    Password: $($Config.Config.ServiceAccount.Password)
"

# View the Old password
Write-Output "Old Password: $($Config.Config.ServiceAccount.Password)"

# Update/Change the password for the SA in memory
$Config.Config.ServiceAccount.Password = "ThisIsANewPassword"

# View the new Password
Write-Output "New Password: $($Config.Config.ServiceAccount.Password)"

# Save the changes to and update the XMl file
$Config.Save("C:\Temp\Config3.xml")

# View the new saved content of the XML file
Get-Content "C:\Temp\Config3.xml"