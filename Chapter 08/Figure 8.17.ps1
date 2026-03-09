# Figure 8.17 - JSON Configuration Object Structure
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates a PowerShell object structure suitable for JSON conversion.

# ============================================================================
# POWERSHELL CONFIGURATION OBJECT
# ============================================================================

# Define a configuration structure using nested hashtables and arrays
# This structure maps naturally to JSON format
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
        # Arrays of hashtables for multiple service accounts
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
# VIEW THE OBJECT STRUCTURE
# ============================================================================

# Display the PowerShell object structure
$Config

# ============================================================================
# STRUCTURE EXPLANATION
# ============================================================================

# This structure uses:
# - Nested hashtables (@{}) for configuration sections
# - Arrays (@()) for lists of similar items (ServiceAccounts)
# - Scalar values for individual settings
#
# This maps directly to JSON objects, arrays, and primitives

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Name                           Value
# ----                           -----
# Config                         {Database, Azure, ServiceAccount}
#
# The output shows the hashtable structure with nested keys
