# Figure 14.31 - View All Task Properties
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (ScheduledTasks module)
# Prerequisites: None (built-in module)

# ============================================================================
# GET ALL PROPERTIES OF A SCHEDULED TASK
# ============================================================================

# Use Select-Object * to view all properties of a scheduled task
# This reveals the complete task configuration
Get-ScheduledTask -TaskName "Advanced Task" | Select-Object *

# Expected Output:
# State                  : Ready
# Actions                : {MSFT_TaskExecAction}
# Author                 : DOMAIN\Administrator
# Date                   : 2024-01-01T10:00:00
# Description            : Advanced scheduled task example
# Documentation          :
# Principal              : MSFT_TaskPrincipal2
# SecurityDescriptor     : D:(A;;FA;;;BA)(A;;FA;;;SY)
# Settings               : MSFT_TaskSettings3
# Source                 :
# TaskName               : Advanced Task
# TaskPath               : \CustomTasks\
# Triggers               : {MSFT_TaskTimeTrigger, MSFT_TaskLogonTrigger}
# URI                    : \CustomTasks\Advanced Task
# Version                :
# PSComputerName         :
#
# Key Properties:
# - Actions: What the task does (run program, send email, etc.)
# - Triggers: When the task runs (schedule, logon, event, etc.)
# - Principal: Security context (user account, privileges)
# - Settings: Task behavior options (restart, stop on idle, etc.)

