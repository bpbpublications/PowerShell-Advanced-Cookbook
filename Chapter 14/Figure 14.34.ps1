# Figure 14.34 - View Registered Scheduled Task Properties
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (ScheduledTasks module)
# Prerequisites: Administrator privileges required
# NOTE: This script first creates a task, then displays all its properties

# ============================================================================
# CREATE AND REGISTER A SCHEDULED TASK
# ============================================================================

# Define the action - what the task executes
$Action = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument "-file C:\Scripts\Update.ps1"

# Define the hourly trigger - repeats every hour starting at 10:00 AM
$HourlyTrigger = New-ScheduledTaskTrigger `
    -Once `
    -At "10:00:00" `
    -RepetitionInterval ([TimeSpan]::FromHours(1))

# Define the login trigger - runs when any user logs on
$LoginTrigger = New-ScheduledTaskTrigger -AtLogon

# Define task settings - priority 3, 1-hour timeout, ignore if already running
$Settings = New-ScheduledTaskSettingsSet -Priority 3 `
    -ExecutionTimeLimit ([TimeSpan]::FromHours(1)) `
    -MultipleInstances IgnoreNew

# Define the principal - run as SYSTEM with highest privileges
$Principal = New-ScheduledTaskPrincipal `
    -RunLevel Highest `
    -UserId "SYSTEM" `
    -LogonType ServiceAccount

# Create the task object combining all components
$Task = New-ScheduledTask `
    -Action $Action `
    -Trigger $HourlyTrigger, $LoginTrigger `
    -Settings $Settings `
    -Principal $Principal `
    -Description "Update Task"

# Register the task with Task Scheduler
Register-ScheduledTask -TaskName "UpdateTask" `
    -InputObject $Task `
    -TaskPath "\CustomTasks\" `
    -Force

# ============================================================================
# VIEW ALL TASK PROPERTIES
# ============================================================================

# Use Select-Object * to view the complete task configuration
# This shows all properties including nested objects
Get-ScheduledTask -TaskName "UpdateTask" | Select-Object *

# Expected Output:
# State                  : Ready
# Actions                : {MSFT_TaskExecAction}
# Author                 : DOMAIN\Administrator
# Date                   : 2024-01-01T10:00:00
# Description            : Update Task
# Documentation          :
# Principal              : MSFT_TaskPrincipal2
# SecurityDescriptor     : D:(A;;FA;;;BA)(A;;FA;;;SY)
# Settings               : MSFT_TaskSettings3
# Source                 :
# TaskName               : UpdateTask
# TaskPath               : \CustomTasks\
# Triggers               : {MSFT_TaskTimeTrigger, MSFT_TaskLogonTrigger}
# URI                    : \CustomTasks\UpdateTask
# Version                :
# PSComputerName         :
#
# To drill into nested objects:
# $Task = Get-ScheduledTask -TaskName "UpdateTask"
# $Task.Actions      - View action details
# $Task.Triggers     - View trigger configuration
# $Task.Principal    - View security context
# $Task.Settings     - View behavior settings

