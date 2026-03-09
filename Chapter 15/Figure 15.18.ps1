# Figure 15.18 - Installing and Uninstalling WeatherLogService
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows
# Prerequisites: WeatherLogService.exe, Administrator privileges

# ============================================================================
# CHECK SERVICE STATUS (BEFORE INSTALLATION)
# ============================================================================

# Verify service doesn't exist yet
Get-Service -Name "WeatherLogService"

# Expected Output (service not found):
# Get-Service: Cannot find any service with service name 'WeatherLogService'.

# ============================================================================
# INSTALL THE SERVICE
# ============================================================================

# Use the -install flag to register the service with Windows
# This creates the service entry in the Services database
.\WeatherLogService.exe -install

# Expected Output:
# WeatherLogService has been installed successfully.

# ============================================================================
# VERIFY SERVICE INSTALLATION
# ============================================================================

# Check that the service now exists
Get-Service -Name "WeatherLogService"

# Expected Output:
# Status   Name                DisplayName
# ------   ----                -----------
# Stopped  WeatherLogService   Weather Log Service

# ============================================================================
# UNINSTALL THE SERVICE
# ============================================================================

# Use the -uninstall flag to remove the service
# Note: Service must be stopped first
.\WeatherLogService.exe -uninstall

# Expected Output:
# WeatherLogService has been uninstalled successfully.

# ============================================================================
# VERIFY SERVICE REMOVAL
# ============================================================================

# Confirm service no longer exists
Get-Service -Name "WeatherLogService"

# Expected Output:
# Get-Service: Cannot find any service with service name 'WeatherLogService'.

