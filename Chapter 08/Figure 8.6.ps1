# Figure 8.6 - Extracting Specific XML Values
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates extracting specific values from XML and using them in scripts.

# ============================================================================
# CREATE AND SAVE XML CONFIGURATION
# ============================================================================

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

# Save to XML file
$XmlObject.Save("C:\Temp\Config3.xml")

# Read from file and assign to variable
$Config = Get-Content C:\Temp\Config3.xml

# ============================================================================
# EXTRACT VALUES AND STORE IN VARIABLES
# ============================================================================

# Extract specific values using dot notation
$AzureSub = $Config.Config.Azure.SubscriptionId
$AzureTen = $Config.Config.Azure.TenantId
$SaName = $Config.Config.ServiceAccount.UserName

# ============================================================================
# USE EXTRACTED VALUES IN OUTPUT
# ============================================================================

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

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Azure information:
#     Subscription: 9c4b3e8a-2d1f-6a7b-5e9c-8d3a6f1c4b9e
#     Tenant: 1e9d4a5f-9b2a-6e7b-3a7d-2c4d60b7ca7
#
# Database information:
#     Instance: DBServer
#     Port: 1433
#     Database: TestDB
#
# ServiceAccount:
#     UserName: Service.DBUser
#     Password: ThisIsARandomPwd
