# Figure 15.20 - Debugging Services in PowerShell Studio
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell Studio - SAPIEN Technologies)
# Prerequisites: PowerShell Studio installed
#
# This figure shows the debugging features for service projects.
#
# ============================================================================
# DEBUGGING WINDOWS SERVICES
# ============================================================================
#
# PowerShell Studio provides special debugging for services:
#
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ Debug Mode                                                               │
# ├─────────────────────────────────────────────────────────────────────────┤
# │                                                                          │
# │ Run service in debug/console mode:                                       │
# │ .\ServiceName.exe -debug                                                │
# │                                                                          │
# │ Debug output appears in console:                                         │
# │ ┌─────────────────────────────────────────────────────────────────────┐ │
# │ │ [DEBUG] Service starting...                                         │ │
# │ │ [DEBUG] Initializing variables                                      │ │
# │ │ [DEBUG] Main loop iteration 1                                       │ │
# │ │ [DEBUG] Weather API call successful                                 │ │
# │ │ [DEBUG] Log entry written                                           │ │
# │ │ [DEBUG] Sleeping for 60 seconds...                                  │ │
# │ │ Press Ctrl+C to stop                                                │ │
# │ └─────────────────────────────────────────────────────────────────────┘ │
# │                                                                          │
# │ PowerShell Studio Features:                                              │
# │ - Set breakpoints in service code                                       │
# │ - Step through execution                                                │
# │ - Inspect variables                                                     │
# │ - Watch expressions                                                     │
# │ - View call stack                                                       │
# │                                                                          │
# └─────────────────────────────────────────────────────────────────────────┘

# No executable code - this is a screenshot figure

