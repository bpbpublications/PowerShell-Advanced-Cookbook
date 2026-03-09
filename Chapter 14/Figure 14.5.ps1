# Figure 14.5 - Register a New Windows Service
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Microsoft.PowerShell.Management module)
# Prerequisites: Administrator privileges, service executable

# ============================================================================
# REGISTER A NEW WINDOWS SERVICE
# ============================================================================

# New-Service creates a new Windows service entry in the registry
# The executable must be designed as a Windows Service (not a regular exe)
# NOTE: Requires Administrator privileges

New-Service -Name "TestService" `
    -DisplayName "TestService" `
    -BinaryPathName C:\Temp\TestService\TestService.exe `
    -Description "This is a simple test service executable" `
    -StartupType Automatic

# Expected Output:
# Status   Name        DisplayName
# ------   ----        -----------
# Stopped  TestService TestService

# ============================================================================
# NEW-SERVICE PARAMETERS
# ============================================================================

# Key Parameters:
# -Name:           The short service name (used in commands)
# -DisplayName:    The friendly name shown in services.msc
# -BinaryPathName: Full path to the service executable
# -Description:    Description shown in service properties
# -StartupType:    Automatic, Manual, Disabled, or AutomaticDelayedStart
#
# Additional Parameters:
# -Credential:     Run service under specific account
# -DependsOn:      Services this service depends on
# -StartupType AutomaticDelayedStart: Starts after boot completes
#
# NOTE: The service is created in Stopped state
# Use Start-Service to start it after creation

