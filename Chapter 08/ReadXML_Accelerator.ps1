# Recipe: Reading and Modifying XML with Type Accelerator
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates reading, navigating, modifying, and saving XML files.

# ============================================================================
# READ XML FILE USING TYPE ACCELERATOR
# ============================================================================

# The [xml] type accelerator converts file content to XmlDocument
[xml]$Config = Get-Content C:\Temp\Config3.xml

# ============================================================================
# EXAMINE OBJECT TYPE AND MEMBERS
# ============================================================================

# View the type and available members
$Config | Get-Member

# ============================================================================
# NAVIGATE XML SECTIONS
# ============================================================================

# Access different configuration sections using dot notation
$Config.Config.Database

$Config.Config.Azure

$Config.Config.ServiceAccount

# ============================================================================
# EXTRACT INDIVIDUAL VALUES
# ============================================================================

# Assign specific values to variables
$DBInstance = $Config.Config.Database.Instance
$DBInstance

$DBPort = $Config.Config.Database.Port
$DBPort

$DBName = $Config.Config.Database.Database
$DBName

# ============================================================================
# USE EXTRACTED VALUES
# ============================================================================

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

# ============================================================================
# MODIFY XML VALUES
# ============================================================================

# View current password
Write-Output "Old Password: $($Config.Config.ServiceAccount.Password)"

# Update value in memory
$Config.Config.ServiceAccount.Password = "ThisIsANewPassword"

# Verify change
Write-Output "New Password: $($Config.Config.ServiceAccount.Password)"

# ============================================================================
# SAVE CHANGES TO FILE
# ============================================================================

# The Save() method writes the modified XML back to file
$Config.Save("C:\Temp\Config3.xml")

# Verify the file was updated
Get-Content "C:\Temp\Config3.xml"
