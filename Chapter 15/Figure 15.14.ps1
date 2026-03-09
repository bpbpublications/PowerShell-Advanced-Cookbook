# Figure 15.14 - Service Recovery Options
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows
# Prerequisites: None
#
# This figure shows the Recovery tab in Service Properties.
#
# ============================================================================
# SERVICE RECOVERY OPTIONS
# ============================================================================
#
# Configure automatic recovery when a service fails:
#
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ Weather Log Service Properties - Recovery Tab                           │
# ├─────────────────────────────────────────────────────────────────────────┤
# │                                                                          │
# │ Select the computer's response if this service fails:                   │
# │                                                                          │
# │ First failure:    [Restart the Service ▼]                               │
# │ Second failure:   [Restart the Service ▼]                               │
# │ Subsequent:       [Take No Action      ▼]                               │
# │                                                                          │
# │ Reset fail count after: [1] days                                        │
# │                                                                          │
# │ Restart service after:  [1] minutes                                     │
# │                                                                          │
# │ [✓] Enable actions for stops with errors                                │
# │                                                                          │
# │ Run program:                                                             │
# │ Program:    [C:\Scripts\ServiceFailure.ps1          ] [Browse...]       │
# │ Parameters: [-ServiceName WeatherLogService         ]                   │
# │                                                                          │
# └─────────────────────────────────────────────────────────────────────────┘
#
# Recovery Actions:
# - Take No Action: Do nothing
# - Restart the Service: Automatically restart
# - Run a Program: Execute a script/program
# - Restart the Computer: Full system restart

# No executable code - this is a screenshot figure

