# Figure 14.4 - Filter Services with Where-Object
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Microsoft.PowerShell.Management module)
# Prerequisites: None (built-in cmdlet)

# ============================================================================
# FILTER SERVICES USING WHERE-OBJECT
# ============================================================================

# Filter services to show only those with DisplayName starting with "Windows"
# Select specific properties for cleaner output
Get-Service | `
    Where-Object { $_.DisplayName.StartsWith("Windows") } | `
    Select-Object Status, StartType, DisplayName

# Expected Output:
# Status  StartType DisplayName
# ------  --------- -----------
# Running Automatic Windows Audio
# Running Automatic Windows Audio Endpoint Builder
# Running Manual    Windows Biometric Service
# Stopped Manual    Windows Camera Frame Server
# Running Automatic Windows Connection Manager
# Stopped Manual    Windows Defender Firewall
# Running Automatic Windows Event Log
# Stopped Disabled  Windows Media Player Network Sharing Service
# Running Automatic Windows Search
# Running Automatic Windows Time
# Running Automatic Windows Update
# ...
#
# Key Properties:
# - Status: Current state (Running, Stopped, etc.)
# - StartType: How the service starts (Automatic, Manual, Disabled)
# - DisplayName: Human-readable service name
#
# NOTE: StartType property is available in PowerShell 6+
# In Windows PowerShell 5.1, use: (Get-Service).StartType

