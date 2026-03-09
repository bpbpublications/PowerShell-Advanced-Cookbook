# Figure 15.16 - Installing Service via MSI
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows
# Prerequisites: Administrator privileges
#
# This figure shows the MSI installer for a Windows Service.
#
# ============================================================================
# MSI INSTALLER FOR WINDOWS SERVICE
# ============================================================================
#
# PowerShell Studio can generate MSI installers for services:
#
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ Weather Log Service Setup                                               │
# ├─────────────────────────────────────────────────────────────────────────┤
# │                                                                          │
# │ Welcome to the Weather Log Service Setup Wizard                         │
# │                                                                          │
# │ This will install Weather Log Service on your computer.                 │
# │                                                                          │
# │ Installation Directory:                                                  │
# │ [C:\Program Files\WeatherLogService\     ] [Browse...]                  │
# │                                                                          │
# │ Service Configuration:                                                   │
# │ [✓] Start service after installation                                    │
# │ [✓] Set startup type to Automatic                                       │
# │                                                                          │
# │                                    [Install] [Cancel]                   │
# │                                                                          │
# └─────────────────────────────────────────────────────────────────────────┘
#
# MSI Benefits:
# - Standard Windows Installer format
# - Supports silent installation: msiexec /i Service.msi /quiet
# - Add/Remove Programs integration
# - Upgrade support
# - Rollback on failure

# No executable code - this is a screenshot figure

