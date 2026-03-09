# Figure 9.2 - AD Module Import on Server 2022
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates native AD module support in PowerShell 7 on Server 2022.

# ============================================================================
# CHECK OPERATING SYSTEM VERSION
# ============================================================================

# Get the current operating system caption
(Get-CimInstance -ClassName Win32_OperatingSystem).Caption

# Expected Output:
# Microsoft Windows Server 2022 Standard

# ============================================================================
# IMPORT ACTIVE DIRECTORY MODULE
# ============================================================================

# On Server 2022, the ActiveDirectory module works natively with PowerShell 7
# No WinPSCompatSession is needed - direct module loading
Import-Module ActiveDirectory

# ============================================================================
# COMPATIBILITY NOTES
# ============================================================================

# Server 2022 Benefits:
# - Native PowerShell 7 support for AD module
# - No compatibility layer overhead
# - Better performance for AD operations
# - Full access to all AD cmdlets without remoting
