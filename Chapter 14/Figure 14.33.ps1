# Figure 14.33 - Create and Register Scheduled Task
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (ScheduledTasks module)
# Prerequisites: Administrator privileges required
# NOTE: Creates a task in \CustomTasks\ folder

# ============================================================================
# DEFINE THE ACTION
# ============================================================================

# Action defines what the task will execute
# -Execute: The program to run
# -Argument: Command-line arguments passed to the program
$Action = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument "-file C:\Scripts\Update.ps1"

# ============================================================================
# DEFINE TRIGGERS
# ============================================================================

# Hourly trigger - runs once at 10:00 AM, then repeats every hour
# -Once: Single occurrence base
# -At: Starting time
# -RepetitionInterval: How often to repeat
$HourlyTrigger = New-ScheduledTaskTrigger `
    -Once `
    -At "10:00:00" `
    -RepetitionInterval ([TimeSpan]::FromHours(1))

# Login trigger - runs whenever any user logs on
# Other trigger types: -AtStartup, -Daily, -Weekly, -AtLogon
$LoginTrigger = New-ScheduledTaskTrigger -AtLogon

# ============================================================================
# DEFINE SETTINGS
# ============================================================================

# Settings control task behavior
# -Priority: 0 (highest) to 10 (lowest), default is 7
# -ExecutionTimeLimit: Maximum run time before task is stopped
# -MultipleInstances: What to do if task is already running
#   Options: Parallel, Queue, IgnoreNew, StopExisting
$Settings = New-ScheduledTaskSettingsSet -Priority 3 `
    -ExecutionTimeLimit ([TimeSpan]::FromHours(1)) `
    -MultipleInstances IgnoreNew

# ============================================================================
# DEFINE THE PRINCIPAL (SECURITY CONTEXT)
# ============================================================================

# Principal defines who runs the task and with what privileges
# -RunLevel: Limited or Highest (admin privileges)
# -UserId: Account to run as (SYSTEM, specific user, or group)
# -LogonType: Interactive, Password, S4U, ServiceAccount, etc.
$Principal = New-ScheduledTaskPrincipal `
    -RunLevel Highest `
    -UserId "SYSTEM" `
    -LogonType ServiceAccount

# ============================================================================
# CREATE THE SCHEDULED TASK OBJECT
# ============================================================================

# Combine all components into a task object
# Multiple triggers can be specified as an array
$Task = New-ScheduledTask `
    -Action $Action `
    -Trigger $HourlyTrigger, $LoginTrigger `
    -Settings $Settings `
    -Principal $Principal `
    -Description "Update Task"

# ============================================================================
# REGISTER THE TASK
# ============================================================================

# Register makes the task available to the Task Scheduler
# -TaskName: Name shown in Task Scheduler
# -InputObject: The task definition object
# -TaskPath: Folder location (backslash-delimited)
# -Force: Overwrite if task already exists
Register-ScheduledTask -TaskName "UpdateTask" `
    -InputObject $Task `
    -TaskPath "\CustomTasks\" `
    -Force

# Expected Output:
# TaskPath                       TaskName     State
# --------                       --------     -----
# \CustomTasks\                  UpdateTask   Ready
#
# The task is now registered and will run:
# 1. Every hour starting at 10:00 AM
# 2. When any user logs on

