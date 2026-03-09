# Recipe: Writing JSON Configuration Files
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates converting PowerShell objects to JSON and writing to file.

# ============================================================================
# CREATE CONFIGURATION OBJECT
# ============================================================================

# Define a configuration structure using nested hashtables
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

# ============================================================================
# CONVERT TO JSON AND SAVE
# ============================================================================

# Option 1: Default depth (2) - WARNING: May truncate nested data!
# $Config | ConvertTo-Json | Out-File C:\Temp\Config1.json

# Option 2: Specify depth to preserve all nested data (RECOMMENDED)
$Config | ConvertTo-Json -Depth 3 | Out-File C:\Temp\Config1.json

# Option 3: Compressed output (single line, no whitespace)
# $Config | ConvertTo-Json -Depth 3 -Compress | Out-File C:\Temp\Config1.json

# ============================================================================
# IMPORTANT: DEPTH PARAMETER
# ============================================================================

# Always calculate the depth of your object structure:
# - Level 1: $Config
# - Level 2: $Config.Config
# - Level 3: $Config.Config.Database.Instance
#
# Set -Depth to at least match your deepest nesting level
