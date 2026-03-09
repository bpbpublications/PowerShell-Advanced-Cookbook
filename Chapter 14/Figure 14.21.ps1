# Figure 14.21 - Format Volume
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Storage module)
# Prerequisites: Administrator privileges, existing partition

# ============================================================================
# FORMAT A PARTITION
# ============================================================================

# Format-Volume creates a file system on a partition
# -DriveLetter: The drive letter of the partition to format
# -FileSystem: The file system type (NTFS, ReFS, exFAT, FAT32)
Format-Volume -DriveLetter E -FileSystem NTFS

# Expected Output:
# DriveLetter FileSystemLabel FileSystem DriveType HealthStatus SizeRemaining   Size
# ----------- --------------- ---------- --------- ------------ -------------   ----
# E                           NTFS       Fixed     Healthy         49.92 GB    49.97 GB
#
# File System Options:
# - NTFS: Default for Windows, supports large files, permissions, encryption
# - ReFS: Resilient File System, good for large data sets and Storage Spaces
# - exFAT: Extended FAT, good for USB drives shared with Mac/Linux
# - FAT32: Legacy, limited to 4GB file size
#
# Additional Parameters:
# -NewFileSystemLabel: Set the volume label
# -AllocationUnitSize: Set cluster size (4096 default for NTFS)
# -Full: Perform full format (slower, writes zeros)
# -Confirm:$false: Skip confirmation prompt
#
# Example with label:
# Format-Volume -DriveLetter E -FileSystem NTFS -NewFileSystemLabel "Data"

