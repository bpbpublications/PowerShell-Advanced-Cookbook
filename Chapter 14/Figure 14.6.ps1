# Figure 14.6 - Start and Stop Services
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Microsoft.PowerShell.Management module)
# Prerequisites: Administrator privileges for most services

# ============================================================================
# CHECK SERVICE STATUS
# ============================================================================

# Check the current status of TestService
Get-Service "TestService"

# Expected Output:
# Status   Name        DisplayName
# ------   ----        -----------
# Stopped  TestService TestService

# ============================================================================
# START A SERVICE
# ============================================================================

# Start the service using pipeline
Get-Service "TestService" | Start-Service

# Verify the service is now running
Get-Service "TestService"

# Expected Output:
# Status   Name        DisplayName
# ------   ----        -----------
# Running  TestService TestService

# ============================================================================
# STOP A SERVICE
# ============================================================================

# Stop the service using pipeline
Get-Service "TestService" | Stop-Service

# Verify the service is now stopped
Get-Service "TestService"

# Expected Output:
# Status   Name        DisplayName
# ------   ----        -----------
# Stopped  TestService TestService
#
# NOTE: Alternative syntax without pipeline:
# Start-Service -Name "TestService"
# Stop-Service -Name "TestService"
#
# Use -Force to stop services with dependent services
# Use Restart-Service for a quick stop and start

