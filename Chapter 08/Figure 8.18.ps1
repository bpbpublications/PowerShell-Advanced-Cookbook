# Figure 8.18 - ConvertTo-Json Depth Warning
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates the default depth limitation when converting to JSON.

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
# CONVERT WITHOUT DEPTH PARAMETER (DEFAULT)
# ============================================================================

# WARNING: Default depth is 2 - nested objects beyond this are truncated!
# PowerShell shows a warning when data is lost due to depth limitation
$Config | ConvertTo-Json | Out-File C:\Temp\Config1.json

# ============================================================================
# THE DEPTH PROBLEM
# ============================================================================

# Default depth = 2 means:
# Level 0: Root object
# Level 1: Config
# Level 2: Database, Azure, ServiceAccount <- conversion stops here
# Level 3+: Instance, Port, etc. <- TRUNCATED to type name strings!

# ============================================================================
# EXPECTED WARNING
# ============================================================================

# WARNING: Resulting JSON is truncated as serialization has exceeded the set depth of 2.
#
# The JSON file will contain truncated data like:
# "Database": "System.Collections.Hashtable"
# instead of the actual Database object contents
