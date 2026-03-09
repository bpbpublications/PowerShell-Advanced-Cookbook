# Figure 9.1 - AD Module Import on Server 2016/Below Build 1809
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates that older Windows versions use WinPSCompatSession for AD module.

# ============================================================================
# CHECK OPERATING SYSTEM VERSION
# ============================================================================

# Get the current operating system caption
# This helps identify which Windows version you're running
(Get-CimInstance -ClassName Win32_OperatingSystem).Caption

# Expected Output (example):
# Microsoft Windows Server 2016 Standard

# ============================================================================
# IMPORT ACTIVE DIRECTORY MODULE
# ============================================================================

# On Server 2016 or builds below 1809, importing the AD module in PowerShell 7
# creates a WinPSCompatSession - a compatibility layer that uses Windows PowerShell
# This is because the AD module is not natively compatible with PowerShell 7
# on older Windows versions

Import-Module ActiveDirectory

# NOTE: You may see output like:
# WARNING: Module ActiveDirectory is loaded in Windows PowerShell using WinPSCompatSession remoting.

# ============================================================================
# COMPATIBILITY NOTES
# ============================================================================

# - Server 2016 and older versions require WinPSCompatSession
# - This adds overhead due to implicit remoting
# - Consider using Windows PowerShell 5.1 for better AD performance on older systems
# - Server 2019 build 1809+ and Server 2022 have native PowerShell 7 support
