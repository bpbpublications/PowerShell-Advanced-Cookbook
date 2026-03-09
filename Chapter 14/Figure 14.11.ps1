# Figure 14.11 - Wait for Process with Background Job
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Notepad is Windows-specific)
# Prerequisites: None

# ============================================================================
# DEMONSTRATE WAIT-PROCESS WITH TIMED TERMINATION
# ============================================================================

# Record the start time
"Start $(Get-Date)"

# Start Notepad process
Start-Process Notepad

# Get the process object for the newly started Notepad
$Proc = Get-Process Notepad

# ============================================================================
# CREATE BACKGROUND JOB TO STOP PROCESS AFTER DELAY
# ============================================================================

# Start a background job that will stop the process after 15 seconds
# This simulates an automated cleanup scenario
Start-Job -ScriptBlock {
    param($ProcId)

    # Wait 15 seconds before stopping the process
    Start-Sleep -Seconds 15

    # Stop the process by its ID
    Stop-Process -Id $ProcId
} -ArgumentList $Proc.Id | Out-Null

# ============================================================================
# WAIT FOR PROCESS TO EXIT
# ============================================================================

# Wait-Process blocks until the specified process exits
# The script will resume when Notepad closes (either manually or by the job)
Wait-Process $Proc.Id

# Record the end time
"Stop $(Get-Date)"

# Expected Output:
# Start 01/01/2024 10:00:00
# Stop 01/01/2024 10:00:15
#
# NOTE: This pattern is useful for:
# - Waiting for installers to complete
# - Implementing timeouts for long-running processes
# - Coordinating process lifecycles in automation scripts

