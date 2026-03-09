# Figure 6.1 - Enable PowerShell Remoting
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires Administrator privileges)
# This enables WinRM service and configures firewall for remote management.

# ============================================================================
# ENABLE PSREMOTING
# ============================================================================

# Enable-PSRemoting configures the computer to receive remote commands
# This command performs the following:
# - Starts or restarts the WinRM service
# - Sets the WinRM service startup type to Automatic
# - Creates a listener to accept requests on any IP address
# - Enables firewall exceptions for WS-Management traffic
# - Registers default session configurations
Enable-PSRemoting

# Expected Output (when run as Administrator):
# WinRM has been updated to receive requests.
# WinRM service type changed successfully.
# WinRM service started.
# WinRM has been updated for remote management.
# WinRM firewall exception enabled.

# Note: Use -Force parameter to suppress all prompts
# Enable-PSRemoting -Force

# Note: Use -SkipNetworkProfileCheck on Windows clients to allow
# remoting on public networks (use with caution)
# Enable-PSRemoting -SkipNetworkProfileCheck
