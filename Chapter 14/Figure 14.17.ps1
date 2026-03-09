# Figure 14.17 - Get Disk Information (Physical Computer)
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Storage module)
# Prerequisites: Administrator privileges for some operations

# ============================================================================
# RETRIEVE DISK INFORMATION
# ============================================================================

# Get-Disk returns information about all disks on the system
# On a physical computer, this shows physical drives
Get-Disk

# Expected Output (Physical Computer):
# Number Friendly Name            Serial Number     HealthStatus OperationalStatus Total Size Partition Style
# ------ -------------            -------------     ------------ ----------------- ---------- ---------------
# 0      Samsung SSD 970 EVO 1TB  S4EVNX0M123456N   Healthy      Online            931.51 GB  GPT
# 1      WDC WD10EZEX-00BN5A0     WD-WMC3T0123456   Healthy      Online            931.51 GB  MBR
# 2      Kingston DataTraveler... 001A23456789      Healthy      Online             14.54 GB  MBR
#
# Key Properties:
# - Number: Disk index (used in other disk commands)
# - HealthStatus: Healthy, Warning, Unhealthy
# - OperationalStatus: Online, Offline, Unknown
# - Total Size: Disk capacity
# - Partition Style: GPT (modern) or MBR (legacy)
#
# NOTE: GPT supports disks > 2TB and more partitions
# MBR is limited to 2TB and 4 primary partitions

