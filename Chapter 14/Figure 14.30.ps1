# Figure 14.30 - Filter Scheduled Tasks
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (ScheduledTasks module)
# Prerequisites: None (built-in module)

# ============================================================================
# LIST TASKS IN A SPECIFIC PATH
# ============================================================================

# Get all scheduled tasks in a specific folder
# -TaskPath filters by the task's folder location
Get-ScheduledTask -TaskPath "\CustomTasks\"

# Expected Output:
# TaskPath        TaskName      State
# --------        --------      -----
# \CustomTasks\   Simple Task   Ready
# \CustomTasks\   Advanced Task Ready

# ============================================================================
# GET A SPECIFIC TASK BY NAME
# ============================================================================

# Get a specific scheduled task by its name
# -TaskName filters by the exact task name
Get-ScheduledTask -TaskName "Simple Task"

# Expected Output:
# TaskPath        TaskName    State
# --------        --------    -----
# \CustomTasks\   Simple Task Ready
#
# NOTE: TaskName is case-insensitive
# Use wildcards for partial matches: Get-ScheduledTask -TaskName "*Update*"
#
# Combine filters:
# Get-ScheduledTask -TaskPath "\Microsoft\Windows\" -TaskName "*Defrag*"

