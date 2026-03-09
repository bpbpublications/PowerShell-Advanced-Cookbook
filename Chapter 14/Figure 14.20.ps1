# Figure 14.20 - Create New Partition
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Storage module)
# Prerequisites: Administrator privileges, available disk space

# ============================================================================
# CREATE A NEW PARTITION
# ============================================================================

# New-Partition creates a new partition on a disk
# -DiskNumber: The disk index to partition
# -UseMaximumSize: Use all available space on the disk
# -AssignDriveLetter: Automatically assign the next available drive letter
New-Partition -DiskNumber 1 -UseMaximumSize -AssignDriveLetter

# Expected Output:
# DiskNumber PartitionNumber DriveLetter Offset      Size     Type
# ---------- --------------- ----------- ------      ----     ----
# 1          1               E           1048576     49.97 GB Basic

# ============================================================================
# VERIFY PARTITION CREATION
# ============================================================================

# List all partitions to verify the new partition was created
Get-Partition

# Expected Output:
# DiskNumber PartitionNumber DriveLetter Offset        Size         Type
# ---------- --------------- ----------- ------        ----         ----
# 0          1                           1048576       100.00 MB    System
# 0          2                           105906176     15.87 MB     Reserved
# 0          3               C           122683392     126.87 GB    Basic
# 1          1               E           1048576       49.97 GB     Basic
#
# Alternative partition creation options:
# -Size: Specify partition size (e.g., -Size 10GB)
# -DriveLetter: Specify a specific drive letter
# -GptType: Specify GPT partition type GUID
#
# NOTE: The new partition is not yet formatted
# Use Format-Volume to create a file system

