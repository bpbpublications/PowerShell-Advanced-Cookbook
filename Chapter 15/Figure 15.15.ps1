# Figure 15.15 - Service Dependencies
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows
# Prerequisites: None
#
# This figure shows the Dependencies tab in Service Properties.
#
# ============================================================================
# SERVICE DEPENDENCIES
# ============================================================================
#
# Services can depend on other services to function:
#
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ Weather Log Service Properties - Dependencies Tab                       │
# ├─────────────────────────────────────────────────────────────────────────┤
# │                                                                          │
# │ Some services depend on other services, system drivers, or load         │
# │ order groups. If a system component is stopped or is not running        │
# │ properly, dependent services can be affected.                           │
# │                                                                          │
# │ This service depends on the following system components:                │
# │ ┌─────────────────────────────────────────────────────────┐            │
# │ │ ▢ Network Location Awareness                            │            │
# │ │   └─ ▢ Network List Service                             │            │
# │ │      └─ ▢ Network Store Interface Service               │            │
# │ └─────────────────────────────────────────────────────────┘            │
# │                                                                          │
# │ The following system components depend on this service:                 │
# │ ┌─────────────────────────────────────────────────────────┐            │
# │ │ (No Dependencies)                                       │            │
# │ └─────────────────────────────────────────────────────────┘            │
# │                                                                          │
# └─────────────────────────────────────────────────────────────────────────┘
#
# PowerShell: Get-Service -Name "ServiceName" | Select-Object -ExpandProperty DependentServices

# No executable code - this is a screenshot figure

