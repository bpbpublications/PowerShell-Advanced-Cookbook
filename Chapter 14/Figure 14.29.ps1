# Figure 14.29 - List Scheduled Tasks
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (ScheduledTasks module)
# Prerequisites: None (built-in module)

# ============================================================================
# LIST ALL SCHEDULED TASKS
# ============================================================================

# Get-ScheduledTask lists all scheduled tasks on the system
# This includes both system and user-created tasks
Get-ScheduledTask

# Expected Output (partial):
# TaskPath                          TaskName                    State
# --------                          --------                    -----
# \                                 MicrosoftEdgeUpdateTaskMa...Ready
# \                                 OneDrive Standalone Update...Ready
# \CustomTasks\                     Simple Task                 Ready
# \CustomTasks\                     Advanced Task               Running
# \Microsoft\Office\                Office Automatic Updates    Ready
# \Microsoft\Windows\Defrag\        ScheduledDefrag             Ready
# \Microsoft\Windows\UpdateOrch...  Schedule Scan               Ready
# ...
#
# Task States:
# - Ready: Task is enabled and waiting for trigger
# - Running: Task is currently executing
# - Disabled: Task exists but won't run
# - Queued: Task is waiting to run
#
# NOTE: Tasks are organized in a folder structure (TaskPath)
# System tasks are typically under \Microsoft\Windows\

