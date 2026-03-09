# Figure 15.21 - Service Account Configuration
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows
# Prerequisites: None
#
# This figure shows the Log On tab for service account configuration.
#
# ============================================================================
# SERVICE ACCOUNT CONFIGURATION
# ============================================================================
#
# Configure which account the service runs under:
#
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ Weather Log Service Properties - Log On Tab                             │
# ├─────────────────────────────────────────────────────────────────────────┤
# │                                                                          │
# │ Log on as:                                                               │
# │                                                                          │
# │ ○ Local System account                                                  │
# │   [✓] Allow service to interact with desktop                           │
# │                                                                          │
# │ ● This account: [DOMAIN\ServiceAccount      ] [Browse...]              │
# │   Password:     [************************   ]                          │
# │   Confirm:      [************************   ]                          │
# │                                                                          │
# │ You can enable or disable this service for the hardware profiles        │
# │ listed below:                                                            │
# │                                                                          │
# │ Hardware Profile                     Service                            │
# │ ─────────────────────────────────────────────────────                   │
# │ Profile 1 (Current)                  Enabled                            │
# │                                                                          │
# └─────────────────────────────────────────────────────────────────────────┘
#
# Account Options:
# - Local System: Highest privileges, no network credentials
# - Local Service: Limited privileges, anonymous network access
# - Network Service: Limited privileges, computer credentials on network
# - Specific Account: Custom permissions, requires password management

# No executable code - this is a screenshot figure

