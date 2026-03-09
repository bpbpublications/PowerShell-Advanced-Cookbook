# Figure 15.9 - Service Project Configuration
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell Studio - SAPIEN Technologies)
# Prerequisites: PowerShell Studio installed
#
# This figure shows the Service Project configuration in PowerShell Studio.
#
# ============================================================================
# SERVICE PROJECT CONFIGURATION
# ============================================================================
#
# When creating a Windows Service project, configure these settings:
#
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ Service Configuration                                                    │
# ├─────────────────────────────────────────────────────────────────────────┤
# │                                                                          │
# │ Service Name:        [WeatherLogService              ]                  │
# │ Display Name:        [Weather Log Service            ]                  │
# │ Description:         [Logs weather data periodically ]                  │
# │                                                                          │
# │ Startup Type:        [Automatic ▼]                                      │
# │   - Automatic: Starts with Windows                                      │
# │   - Manual: Must be started manually                                    │
# │   - Disabled: Cannot be started                                         │
# │                                                                          │
# │ Service Account:     [LocalSystem ▼]                                    │
# │   - LocalSystem: Full system access                                     │
# │   - LocalService: Limited local access                                  │
# │   - NetworkService: Network access with limited local                   │
# │   - User Account: Specific user credentials                             │
# │                                                                          │
# │ [✓] Allow Pause and Continue                                            │
# │ [ ] Interact with Desktop                                               │
# │                                                                          │
# └─────────────────────────────────────────────────────────────────────────┘

# No executable code - this is a screenshot figure

