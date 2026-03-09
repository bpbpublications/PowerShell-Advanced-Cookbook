# Figure 14.18 - Get Disk Information (Virtual Machine)
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Storage module)
# Prerequisites: Virtual machine environment

# ============================================================================
# RETRIEVE DISK INFORMATION ON VIRTUAL MACHINE
# ============================================================================

# Get-Disk on a virtual machine shows virtual disks
# The output format is the same, but disk names reflect virtualization
Get-Disk

# Expected Output (Virtual Machine):
# Number Friendly Name                    Serial Number HealthStatus OperationalStatus Total Size Partition Style
# ------ -------------                    ------------- ------------ ----------------- ---------- ---------------
# 0      Msft Virtual Disk                              Healthy      Online            127.00 GB  GPT
# 1      Msft Virtual Disk                              Healthy      Online             50.00 GB  RAW
#
# Virtual Disk Characteristics:
# - Friendly Name: Usually "Msft Virtual Disk" for Hyper-V
# - Serial Number: Often blank for virtual disks
# - RAW Partition Style: Disk not yet initialized
#
# Common Virtual Disk Providers:
# - Hyper-V: "Msft Virtual Disk"
# - VMware: "VMware Virtual disk"
# - VirtualBox: "VBOX HARDDISK"
#
# NOTE: New virtual disks are typically RAW and need initialization:
# Initialize-Disk -Number 1 -PartitionStyle GPT

