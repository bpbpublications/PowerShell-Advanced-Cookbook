# Figure 13.2 - PowerShell Version Selection in VS Code
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (VS Code with PowerShell extension)
# Prerequisites: Visual Studio Code, PowerShell extension

# ============================================================================
# SELECTING POWERSHELL VERSION IN VS CODE
# ============================================================================

# This figure shows how to change the PowerShell version in VS Code.
#
# DSC configurations require Windows PowerShell 5.1 for most operations.
# PowerShell 7+ has limited DSC support through the PSDesiredStateConfiguration module.
#
# To change PowerShell version in VS Code:
# 1. Open the Command Palette (Ctrl+Shift+P or Cmd+Shift+P)
# 2. Type "PowerShell: Show Session Menu" or "PowerShell: Select Version"
# 3. Select the desired PowerShell version from the list
#
# Available versions typically include:
# - Windows PowerShell (5.1) - Required for full DSC support
# - PowerShell 7.x - Limited DSC support
#
# NOTE: For DSC development, Windows PowerShell 5.1 is recommended
# as it provides full support for all DSC resources and features.

# Check current PowerShell version
$PSVersionTable.PSVersion

# Expected Output:
# Major  Minor  Build  Revision
# -----  -----  -----  --------
# 5      1      xxxxx  xxxx

