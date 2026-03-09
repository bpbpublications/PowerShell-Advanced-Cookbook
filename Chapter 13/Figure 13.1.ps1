# Figure 13.1 - Push and Pull DSC Methods
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module

# ============================================================================
# DSC DEPLOYMENT METHODS OVERVIEW
# ============================================================================

# This figure illustrates the two primary DSC deployment methods:
#
# PUSH MODE:
# - Administrator manually pushes configurations to target nodes
# - Uses Start-DscConfiguration cmdlet
# - Suitable for smaller environments or ad-hoc deployments
# - No central server required
# - Configuration is applied immediately when pushed
#
# PULL MODE:
# - Target nodes pull configurations from a DSC Pull Server
# - Nodes check for updates at regular intervals
# - Better for large-scale enterprise deployments
# - Provides centralized management and reporting
# - Requires DSC Pull Server infrastructure (HTTP/HTTPS or SMB)
#
# Key Differences:
# ┌─────────────┬─────────────────────────┬─────────────────────────┐
# │ Aspect      │ Push Mode               │ Pull Mode               │
# ├─────────────┼─────────────────────────┼─────────────────────────┤
# │ Initiation  │ Admin pushes config     │ Node pulls config       │
# │ Scale       │ Small environments      │ Large environments      │
# │ Server      │ Not required            │ Pull server required    │
# │ Timing      │ Immediate               │ Scheduled intervals     │
# │ Reporting   │ Manual                  │ Centralized             │
# └─────────────┴─────────────────────────┴─────────────────────────┘

