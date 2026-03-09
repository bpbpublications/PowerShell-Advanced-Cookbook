# Figure 14.32 - View Scheduled Task Components
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (ScheduledTasks module)
# Prerequisites: None (built-in module)

# ============================================================================
# STORE SCHEDULED TASK IN VARIABLE
# ============================================================================

# Get the task and store it in a variable for easier exploration
$Task = Get-ScheduledTask -TaskName "Advanced Task" | Select-Object *

# ============================================================================
# VIEW TASK ACTIONS
# ============================================================================

# Actions define what the task does when triggered
$Task.Actions

# Expected Output:
# Id               :
# Arguments        : -file C:\Scripts\Update.ps1
# Execute          : powershell.exe
# WorkingDirectory :
# PSComputerName   :

# ============================================================================
# VIEW TASK PRINCIPAL
# ============================================================================

# Principal defines the security context for the task
$Task.Principal

# Expected Output:
# DisplayName  :
# GroupId      :
# Id           : Author
# LogonType    : ServiceAccount
# RunLevel     : Highest
# UserId       : SYSTEM
# PSComputerName:

# ============================================================================
# VIEW TASK SETTINGS
# ============================================================================

# Settings control task behavior (timeouts, restarts, etc.)
$Task.Settings

# Expected Output:
# AllowDemandStart             : True
# AllowHardTerminate           : True
# Compatibility                : Win8
# DeleteExpiredTaskAfter       :
# DisallowStartIfOnBatteries   : False
# Enabled                      : True
# ExecutionTimeLimit           : PT1H
# ...

# ============================================================================
# VIEW TASK TRIGGERS
# ============================================================================

# Triggers define when the task runs
$Task.Triggers

# Expected Output:
# Enabled            : True
# EndBoundary        :
# ExecutionTimeLimit :
# Id                 :
# Repetition         : MSFT_TaskRepetitionPattern
# StartBoundary      : 2024-01-01T10:00:00
# PSComputerName     :

