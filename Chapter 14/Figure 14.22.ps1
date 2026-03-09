# Figure 14.22 - Use New Volume
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Microsoft.PowerShell.Management module)
# Prerequisites: Formatted volume with drive letter

# ============================================================================
# NAVIGATE TO NEW VOLUME
# ============================================================================

# Change location to the new volume
# This sets the current working directory to E:\
cd E:

# Or using the full cmdlet name:
# Set-Location -Path E:

# ============================================================================
# CREATE FOLDER ON NEW VOLUME
# ============================================================================

# Create a new folder on the volume
# mkdir is an alias for New-Item -ItemType Directory
mkdir Test

# Expected Output:
#     Directory: E:\
#
# Mode                LastWriteTime         Length Name
# ----                -------------         ------ ----
# d-----        1/1/2024  10:00 AM                 Test
#
# Alternative syntax:
# New-Item -Path E:\Test -ItemType Directory
#
# NOTE: After creating partitions and volumes, they're ready for use
# Full disk setup workflow:
# 1. Initialize-Disk (if RAW)
# 2. New-Partition
# 3. Format-Volume
# 4. Use the volume (copy files, create folders, etc.)

