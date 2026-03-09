# Figure 13.3 - PSDesiredStateConfiguration Module Commands
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module (built-in)

# ============================================================================
# LIST DSC MODULE COMMANDS
# ============================================================================

# Get all commands available in the PSDesiredStateConfiguration module
# This module is built into Windows PowerShell 5.1
Get-Command -Module PSDesiredStateConfiguration

# Expected Output:
# CommandType  Name                                    Version    Source
# -----------  ----                                    -------    ------
# Function     Configuration                           1.1        PSDesiredStateConfiguration
# Function     Disable-DscDebug                        1.1        PSDesiredStateConfiguration
# Function     Enable-DscDebug                         1.1        PSDesiredStateConfiguration
# Function     Get-DscConfiguration                    1.1        PSDesiredStateConfiguration
# Function     Get-DscConfigurationStatus              1.1        PSDesiredStateConfiguration
# Function     Get-DscLocalConfigurationManager        1.1        PSDesiredStateConfiguration
# Function     Get-DscResource                         1.1        PSDesiredStateConfiguration
# Function     New-DscChecksum                         1.1        PSDesiredStateConfiguration
# Function     Remove-DscConfigurationDocument         1.1        PSDesiredStateConfiguration
# Function     Restore-DscConfiguration                1.1        PSDesiredStateConfiguration
# Function     Set-DscLocalConfigurationManager        1.1        PSDesiredStateConfiguration
# Function     Start-DscConfiguration                  1.1        PSDesiredStateConfiguration
# Function     Stop-DscConfiguration                   1.1        PSDesiredStateConfiguration
# Function     Test-DscConfiguration                   1.1        PSDesiredStateConfiguration
# Function     Update-DscConfiguration                 1.1        PSDesiredStateConfiguration
#
# Key Commands:
# - Configuration: Define DSC configurations
# - Start-DscConfiguration: Apply configurations to nodes
# - Get-DscConfiguration: View current configuration
# - Get-DscLocalConfigurationManager: View LCM settings
# - Set-DscLocalConfigurationManager: Configure LCM settings
# - Get-DscResource: List available DSC resources

