# Figure 8.23 - Accessing JSON Data with Dot Notation
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates accessing specific properties from JSON data using dot notation.

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

# Write JSON config file
$Config | ConvertTo-Json -Depth 3 | Out-File C:\Temp\Config1.json

# ============================================================================
# READ JSON AND ACCESS PROPERTIES
# ============================================================================

# Read and convert from JSON
$Config = Get-Content C:\Temp\Config1.json | ConvertFrom-Json

# Access specific property values using dot notation
$Config.Config.Azure.TenantID

$Config.Config.Azure.ClientID

$Config.Config.Database.Instance

# ============================================================================
# DOT NOTATION PATTERN
# ============================================================================

# $Object.Level1.Level2.Property
# Each dot navigates one level deeper into the object hierarchy
#
# JSON structure:          PowerShell access:
# { "Config": {            $Config.Config
#     "Azure": {           $Config.Config.Azure
#       "TenantID": "..."  $Config.Config.Azure.TenantID
#     }
#   }
# }

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# $Config.Config.Azure.TenantID:
# 1e9d4a5f-9b2a-6e7b-3a7d-2c4d60b7ca7
#
# $Config.Config.Azure.ClientID:
# a8d2c4b6-1f7e-4e6a-b2d9-8c3a9d5e1f4c
#
# $Config.Config.Database.Instance:
# DBServer
