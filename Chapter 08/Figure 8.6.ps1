[xml]$XmlObject = @"
<?xml version="1.0" encoding="UTF-8"?>
<Config>
    <Database id="database">
        <Instance>DBServer</Instance>
        <Port>1433</Port>
        <Database>TestDB</Database>
    </Database>
    <Azure id="azure">
        <SubscriptionID>9c4b3e8a-2d1f-6a7b-5e9c-8d3a6f1c4b9e</SubscriptionID>
        <TenantID>1e9d4a5f-9b2a-6e7b-3a7d-2c4d60b7ca7</TenantID>
        <ClientID>a8d2c4b6-1f7e-4e6a-b2d9-8c3a9d5e1f4c</ClientID>
        <ClientSecret>5e2d4b3a-7c8d-9b2a-6e4f-7a1f6c3b2d8a</ClientSecret>
    </Azure>
    <ServiceAccount id="serviceaccount">
        <UserName>Service.DBUser</UserName>
        <Password>ThisIsARandomPwd</Password>
    </ServiceAccount>
</Config>
"@

# Save to xml file
$XmlObject.Save("C:\Temp\Config3.xml")

# Read from file, assign to variable
$Config = Get-Content C:\Temp\Config3.xml

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
