# Figure 14.19 - Get Disk and Partition Information
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Storage module)
# Prerequisites: None (built-in module)

# ============================================================================
# GET SPECIFIC DISK BY DEVICE ID
# ============================================================================

# Use -DeviceId (or -Number) to get information about a specific disk
Get-Disk -DeviceId 1

# Expected Output:
# Number Friendly Name       Serial Number HealthStatus OperationalStatus Total Size Partition Style
# ------ -------------       ------------- ------------ ----------------- ---------- ---------------
# 1      Msft Virtual Disk                 Healthy      Online             50.00 GB  GPT

# ============================================================================
# LIST ALL PARTITIONS
# ============================================================================

# Get-Partition lists all partitions on all disks
Get-Partition

# Expected Output:
# DiskNumber PartitionNumber DriveLetter Offset        Size         Type
# ---------- --------------- ----------- ------        ----         ----
# 0          1                           1048576       100.00 MB    System
# 0          2                           105906176     15.87 MB     Reserved
# 0          3               C           122683392     126.87 GB    Basic
# 1          1               E           1048576       49.97 GB     Basic
#
# Partition Types:
# - System: EFI System Partition (ESP)
# - Reserved: Microsoft Reserved Partition (MSR)
# - Basic: Standard data partition
# - Recovery: Windows Recovery Environment
#
# To get partitions for a specific disk:
# Get-Partition -DiskNumber 1

