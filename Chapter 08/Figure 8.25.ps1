# Figure 8.25 - Accessing JSON Array Items by Index
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates accessing specific array elements using index notation.

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
# READ JSON AND ACCESS BY INDEX
# ============================================================================

# Read and convert from JSON
$Config = Get-Content C:\Temp\Config1.json | ConvertFrom-Json

# Access specific array elements using zero-based index
# Index [0] = first element (Service.DBUser)
$Config.Config.ServiceAccount[0].UserName
$Config.Config.ServiceAccount[0].Password

# Index [1] = second element (Service.AzureUser)
$Config.Config.ServiceAccount[1].UserName
$Config.Config.ServiceAccount[1].Password

# ============================================================================
# INDEX ACCESS PATTERN
# ============================================================================

# Array[index].Property
# - [0] = First item
# - [1] = Second item
# - [-1] = Last item (PowerShell supports negative indexing)
# - [0..1] = First two items (range)

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# $Config.Config.ServiceAccount[0].UserName:
# Service.DBUser
#
# $Config.Config.ServiceAccount[0].Password:
# ThisIsARandomPwd
#
# $Config.Config.ServiceAccount[1].UserName:
# Service.AzureUser
#
# $Config.Config.ServiceAccount[1].Password:
# VerySecretPwd
