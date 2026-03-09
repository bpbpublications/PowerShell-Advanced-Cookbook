# Figure 8.24 - Accessing JSON Arrays
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates accessing array data within JSON using dot notation.

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
# READ JSON AND ACCESS ARRAY DATA
# ============================================================================

# Read and convert from JSON
$Config = Get-Content C:\Temp\Config1.json | ConvertFrom-Json

# Access the entire ServiceAccount array
$Config.Config.ServiceAccount

# Access specific properties across all array items
# PowerShell unrolls arrays and returns all matching properties
$Config.Config.ServiceAccount.UserName

$Config.Config.ServiceAccount.Password

# ============================================================================
# ARRAY ACCESS EXPLANATION
# ============================================================================

# When you access a property on an array, PowerShell returns that property
# from ALL items in the array (member enumeration feature)
#
# $Config.Config.ServiceAccount           -> Returns both account objects
# $Config.Config.ServiceAccount.UserName  -> Returns: Service.DBUser, Service.AzureUser
# $Config.Config.ServiceAccount.Password  -> Returns: ThisIsARandomPwd, VerySecretPwd

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# $Config.Config.ServiceAccount:
# Id UserName           Password
# -- --------           --------
# 1  Service.DBUser     ThisIsARandomPwd
# 2  Service.AzureUser  VerySecretPwd
#
# $Config.Config.ServiceAccount.UserName:
# Service.DBUser
# Service.AzureUser
#
# $Config.Config.ServiceAccount.Password:
# ThisIsARandomPwd
# VerySecretPwd
