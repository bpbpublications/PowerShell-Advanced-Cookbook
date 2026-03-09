# Figure 4.18 - Error Handling in Background Jobs (Receive-Job Method)
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates an alternative approach to job error handling:
# using try/catch around Receive-Job with -ErrorAction Stop.
# Requires: File1.txt, File2.txt, File3.txt in current directory

# ============================================================================
# JOB DEFINITION
# ============================================================================

$Job = Start-Job -ScriptBlock {
    $Files = @("File1.txt", "File2.txt", "NonExistingFile.txt", "File3.txt")

    foreach ($File in $Files) {
        try {
            $Content = Get-Content -Path $File -ErrorAction Stop
            "Content from $($File) successfully extracted: $($Content)"
        }
        catch {
            # Report the error and re-throw to fail the job
            "Failed to load content from $($File): $_"
            throw
        }
    }
}

# Wait for completion
Wait-Job $Job | Out-Null

# ============================================================================
# ERROR HANDLING VIA RECEIVE-JOB
# ============================================================================

# This approach catches errors when RECEIVING job results
# rather than checking job state beforehand

try {
    # -ErrorAction Stop makes Receive-Job throw if the job failed
    Receive-Job $Job -ErrorAction Stop
}
catch {
    # Handle the job's error here
    Write-Error "Error occurred in the job: $_"
}

# ============================================================================
# COMPARISON: STATE CHECK VS RECEIVE-JOB
# ============================================================================

# METHOD 1: Check Job.State (Figure 4.17)
# - Check state BEFORE receiving output
# - Access error via ChildJobs[0].JobStateInfo.Reason
# - Good for: deciding whether to receive output at all

# METHOD 2: Receive-Job with ErrorAction Stop (This figure)
# - Let Receive-Job throw on error
# - Catch with standard try/catch
# - Good for: treating job errors like any other error

# ============================================================================
# WHEN TO USE WHICH METHOD
# ============================================================================

# USE STATE CHECK WHEN:
# - You need to take different actions based on job state
# - You want to access the original exception details
# - You need to inspect multiple jobs and handle each differently

# USE RECEIVE-JOB CATCH WHEN:
# - You want uniform error handling
# - You're already using try/catch patterns
# - You want the error to propagate naturally

# ============================================================================
# IMPORTANT NOTE
# ============================================================================

# When a job fails, Receive-Job with ErrorAction Stop will:
# 1. Return any output produced BEFORE the error
# 2. Then throw an exception with the error details

# This means you may get PARTIAL output before the error!

# Expected Output:
# Content from File1.txt successfully extracted: (contents)
# Content from File2.txt successfully extracted: (contents)
# Failed to load content from NonExistingFile.txt: ...
# Error occurred in the job: Cannot find path '...\NonExistingFile.txt'...
