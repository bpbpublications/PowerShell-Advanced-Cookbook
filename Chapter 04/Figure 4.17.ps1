# Figure 4.17 - Error Handling in Background Jobs (Job State Method)
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates how to detect and handle errors in background jobs
# by checking the Job.State property after the job completes.
# Requires: File1.txt, File2.txt, File3.txt in current directory

# ============================================================================
# JOB ERROR HANDLING: CHECKING JOB STATE
# ============================================================================

# Define the script block that runs in the background job
# This script block processes multiple files, some of which may not exist

$Block = {
    $Files = @("File1.txt", "File2.txt", "NonExistingFile.txt", "File3.txt")

    foreach ($File in $Files) {
        try {
            # ErrorAction Stop converts file-not-found to terminating error
            $Content = Get-Content -Path $File -ErrorAction Stop
            "Content from $($File) successfully extracted: $($Content)"
        }
        catch {
            # Log the error but also re-throw to mark the job as Failed
            "Failed to load content from $($File): $_"
            throw  # This causes the job to enter "Failed" state
        }
    }
}

# ============================================================================
# START AND MONITOR THE JOB
# ============================================================================

# Start the background job
$Job = Start-Job -ScriptBlock $Block

# Wait for the job to complete (blocking)
Wait-Job $Job | Out-Null

# ============================================================================
# CHECK JOB STATE FOR ERRORS
# ============================================================================

# The Job.State property indicates if the job succeeded or failed
# Possible states: Running, Completed, Failed, Stopped, Blocked

if ($Job.State -eq "Failed") {
    # Job failed - extract error information from ChildJobs
    # ChildJobs[0].JobStateInfo.Reason contains the exception
    Write-Error "Job $($Job.State) $($Job.ChildJobs[0].JobStateInfo.Reason.Message)."
}
else {
    # Job completed successfully
    Write-Output "Job $($Job.State)."
}

# ============================================================================
# RETRIEVE JOB OUTPUT
# ============================================================================

# Receive-Job gets the output produced by the job
# SilentlyContinue suppresses errors during retrieval (we already handled them)
Receive-Job $Job -ErrorAction SilentlyContinue

# ============================================================================
# KEY CONCEPTS: JOB ERROR DETECTION
# ============================================================================

# JOB STATES:
# - Completed : Job finished without terminating errors
# - Failed    : Job threw an unhandled terminating error
# - Running   : Job still executing
# - Stopped   : Job was stopped manually (Stop-Job)

# ACCESSING JOB ERRORS:
# - $Job.State                                    : Overall state
# - $Job.ChildJobs[0].JobStateInfo.Reason         : Exception object
# - $Job.ChildJobs[0].JobStateInfo.Reason.Message : Error message

# WHY USE CHILDJOBS?
# Every Start-Job creates a parent job with one child job
# The actual work and errors are in the child job

# IMPORTANT:
# throw inside a job marks the ENTIRE job as Failed
# Non-terminating errors do NOT change the job state

# Expected Output (with missing file):
# Job Failed Cannot find path '...\NonExistingFile.txt'...
# Content from File1.txt successfully extracted: (contents)
# Content from File2.txt successfully extracted: (contents)
# Failed to load content from NonExistingFile.txt: ...
