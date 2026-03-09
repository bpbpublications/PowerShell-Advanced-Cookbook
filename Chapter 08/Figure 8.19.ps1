# Figure 8.19 - Viewing Truncated JSON Data
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates viewing JSON output that was truncated due to depth limitation.

# ============================================================================
# CONFIGURATION WITH NESTED STRUCTURE
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

# Convert without proper depth - data will be truncated
$Config | ConvertTo-Json | Out-File C:\Temp\Config1.json

# ============================================================================
# VIEW TRUNCATED JSON CONTENT
# ============================================================================

# View the file content to see the truncated data
Get-Content C:\Temp\Config1.json

# ============================================================================
# EXPECTED OUTPUT (TRUNCATED)
# ============================================================================

# {
#   "Config": {
#     "Database": "System.Collections.Hashtable",
#     "Azure": "System.Collections.Hashtable",
#     "ServiceAccount": [
#       "System.Collections.Hashtable",
#       "System.Collections.Hashtable"
#     ]
#   }
# }
#
# Note: The actual hashtable contents are replaced with type names!
# This is unusable - always use -Depth parameter for nested objects
