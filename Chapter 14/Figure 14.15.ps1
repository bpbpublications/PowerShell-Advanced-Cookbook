# Figure 14.15 - Test Network Connectivity
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (Microsoft.PowerShell.Management module)
# Prerequisites: Network connectivity

# ============================================================================
# PING MULTIPLE IP ADDRESSES
# ============================================================================

# Test-Connection is the PowerShell equivalent of ping
# -TargetName accepts an array of addresses to test
# -Count specifies how many ping requests per target
Test-Connection -TargetName @(
    "192.168.22.221",
    "192.168.22.222",
    "192.168.22.223") `
    -Count 1 | Select-Object Address, Status

# Expected Output:
# Address         Status
# -------         ------
# 192.168.22.221  Success
# 192.168.22.222  Success
# 192.168.22.223  TimedOut
#
# Status Values:
# - Success: Host responded to ping
# - TimedOut: No response within timeout period
# - DestinationHostUnreachable: Network path not available
# - DestinationNetworkUnreachable: Network not reachable
#
# Additional Parameters:
# -Quiet: Returns only True/False (good for scripts)
# -TimeoutSeconds: Set custom timeout
# -BufferSize: Set ping packet size
# -MaxHops: Set TTL (Time To Live)
#
# Example for scripting:
# if (Test-Connection "192.168.22.221" -Count 1 -Quiet) { "Host is up" }

