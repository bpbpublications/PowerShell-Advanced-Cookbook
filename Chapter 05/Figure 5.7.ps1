# Figure 5.7 - Windows Cmdlet on Linux (Error Demonstration)
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates what happens when running Windows-specific cmdlets on Linux.
# Get-WinEvent is not available on non-Windows platforms.
#
# Platform: This script demonstrates a cross-platform limitation

# ============================================================================
# ATTEMPTING WINDOWS CMDLET ON LINUX
# ============================================================================

# This command works on Windows but fails on Linux/macOS
# Get-WinEvent is a Windows-only cmdlet
Get-WinEvent -LogName System | Select-Object -First 1

# ============================================================================
# EXPECTED OUTPUT (Linux/macOS)
# ============================================================================

# Get-WinEvent: The 'Get-WinEvent' command was found in the module
# 'Microsoft.PowerShell.Diagnostics', but the module could not be loaded.
# For more information, run 'Import-Module Microsoft.PowerShell.Diagnostics'.

# Or on some versions:
# Get-WinEvent: The term 'Get-WinEvent' is not recognized as a name of a
# cmdlet, function, script file, or executable program.

# ============================================================================
# CROSS-PLATFORM ALTERNATIVES
# ============================================================================

# Use platform detection to run appropriate commands:
# if ($IsWindows) {
#     Get-WinEvent -LogName System | Select-Object -First 5
# }
# elseif ($IsLinux) {
#     # Use journalctl for systemd logs
#     journalctl --lines=5 --no-pager
# }
# elseif ($IsMacOS) {
#     # Use log command for unified logging
#     log show --last 5m --predicate 'eventType == logEvent' | Select-Object -First 5
# }

# ============================================================================
# LINUX LOG ALTERNATIVES
# ============================================================================

# journalctl (systemd journal):
# journalctl -n 10                    # Last 10 entries
# journalctl -p err                   # Only errors
# journalctl --since "1 hour ago"     # Recent entries

# Traditional log files:
# Get-Content /var/log/syslog | Select-Object -Last 10
# Get-Content /var/log/messages | Select-Object -Last 10
# Get-Content /var/log/auth.log | Select-Object -Last 10

