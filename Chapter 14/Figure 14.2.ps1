# Figure 14.2 - List All Services
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Microsoft.PowerShell.Management module)
# Prerequisites: None (built-in cmdlet)

# ============================================================================
# LIST ALL SERVICES ON THE SYSTEM
# ============================================================================

# Get-Service without parameters lists all services on the local system
# This returns ServiceController objects with status and configuration info
Get-Service

# Expected Output (partial):
# Status   Name               DisplayName
# ------   ----               -----------
# Running  AdobeARMservice    Adobe Acrobat Update Service
# Stopped  AJRouter           AllJoyn Router Service
# Stopped  ALG                Application Layer Gateway Service
# Running  AppIDSvc           Application Identity
# Stopped  Appinfo            Application Information
# Running  AudioEndpointBu... Windows Audio Endpoint Builder
# Running  Audiosrv           Windows Audio
# ...
#
# Key Properties:
# - Status: Running, Stopped, Paused, StartPending, StopPending
# - Name: The short service name (used in commands)
# - DisplayName: The friendly name shown in services.msc
#
# NOTE: Running as Administrator shows all services
# Non-admin users may see limited results

