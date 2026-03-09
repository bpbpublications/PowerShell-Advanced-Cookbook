# Figure 8.22 - ConvertFrom-Json Type Information
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates reading JSON and examining the resulting object type.

# ============================================================================
# CREATE AND SAVE JSON CONFIG
# ============================================================================

$Config = @{
    Config = @{
        Database = @{
            Instance = "DBServer"
            Port     = 1433
            Database = "TestDB"
        }
        Azure = @{
            SubscriptionID = "9c4b3e8a-2d1f-6a7b-5e9c-8d3a6f1c4b9e"
            TenantID       = "1e9d4a5f-9b2a-6e7b-3a7d-2c4d60b7ca7"
            ClientID       = "a8d2c4b6-1f7e-4e6a-b2d9-8c3a9d5e1f4c"
            ClientSecret   = "5e2d4b3a-7c8d-9b2a-6e4f-7a1f6c3b2d8a"
        }
        ServiceAccount = @(
            @{
                Id       = 1
                UserName = "Service.DBUser"
                Password = "ThisIsARandomPwd"
            }
            @{
                Id       = 2
                UserName = "Service.AzureUser"
                Password = "VerySecretPwd"
            }
        )
    }
}

# Write JSON config file with proper depth
$Config | ConvertTo-Json -Depth 3 | Out-File C:\Temp\Config1.json

# ============================================================================
# READ JSON AND CONVERT TO OBJECT
# ============================================================================

# Read file content and convert from JSON to PowerShell object
$Config = Get-Content C:\Temp\Config1.json | ConvertFrom-Json

# View the restored object
$Config

# Check the type of the restored object
$Config.GetType()

# ============================================================================
# TYPE INFORMATION
# ============================================================================

# ConvertFrom-Json creates PSCustomObject, not Hashtable!
# This is important because:
# - PSCustomObject properties are accessed with dot notation
# - You cannot add new keys like with hashtables ($obj["newkey"] = value)
# - Use -AsHashtable parameter in PowerShell 7+ if you need hashtables

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# $Config:
# Config
# ------
# @{Database=; Azure=; ServiceAccount=System.Object[]}
#
# $Config.GetType():
# IsPublic IsSerial Name                                     BaseType
# -------- -------- ----                                     --------
# True     False    PSCustomObject                           System.Object
