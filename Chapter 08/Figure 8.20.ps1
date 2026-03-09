# Figure 8.20 - ConvertTo-Json with Depth Parameter
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates using the -Depth parameter to preserve nested object data.

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

# ============================================================================
# CONVERT WITH PROPER DEPTH
# ============================================================================

# Use -Depth 3 to accommodate the nested object structure
# Config (1) -> Database/Azure/ServiceAccount (2) -> Properties (3)
$Config | ConvertTo-Json -Depth 3 | Out-File C:\Temp\Config1.json

# View the complete JSON content
Get-Content C:\Temp\Config1.json

# ============================================================================
# DEPTH GUIDELINE
# ============================================================================

# Set -Depth to match your deepest nesting level:
# -Depth 1: Simple flat objects
# -Depth 2: One level of nesting
# -Depth 3: Two levels of nesting (like this config)
# -Depth 10+: Deep/complex structures (PowerShell 7 default is 2)
#
# When in doubt, use a higher depth value - there's minimal performance impact

# ============================================================================
# EXPECTED OUTPUT (COMPLETE)
# ============================================================================

# {
#   "Config": {
#     "Database": {
#       "Instance": "DBServer",
#       "Port": 1433,
#       "Database": "TestDB"
#     },
#     "Azure": {
#       "SubscriptionID": "9c4b3e8a-2d1f-6a7b-5e9c-8d3a6f1c4b9e",
#       ...
#     },
#     "ServiceAccount": [
#       { "Id": 1, "UserName": "Service.DBUser", ... },
#       { "Id": 2, "UserName": "Service.AzureUser", ... }
#     ]
#   }
# }
