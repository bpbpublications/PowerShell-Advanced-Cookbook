# Figure 4.19 - Graceful Error Handling in Jobs with Logging
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows (uses C:\temp for log files)
#
# This demonstrates a production-ready pattern: handling errors WITHIN
# the job without failing it, while logging results for later analysis.
# Requires: File1.txt, File2.txt, File3.txt in current directory

# ============================================================================
# JOB WITH INTERNAL ERROR HANDLING
# ============================================================================

$Block = {
    $Files = @("File1.txt", "File2.txt", "NonExistingFile.txt", "File3.txt")

    foreach ($File in $Files) {
        # Create a structured result object for each file
        $Data = [PSCustomObject]@{
            Date       = Get-Date -Format "dd-MM-yyyy HH:mm:ss"
            ErrorLevel = ""
            Message    = ""
        }

        try {
            $Content = Get-Content -Path $File -ErrorAction Stop

            # Success: populate with success data
            $Data.Message = "Content from $($File) successfully logged: $($Content)"
            $Data.ErrorLevel = "Info"
        }
        catch {
            # Failure: populate with error data
            # NOTE: We do NOT re-throw, so job continues processing other files
            $Data.Message = "Failed to load content from $($File): $_"
            $Data.ErrorLevel = "Error"
        }

        # Log each result to JSON file (append mode for multiple entries)
        $Data | ConvertTo-Json -Compress | Out-File -FilePath "C:\temp\ErrorLog.json" -Append

        # Also output the data for Receive-Job to collect
        $Data
    }
}

# ============================================================================
# START AND RETRIEVE JOB
# ============================================================================

$Job = Start-Job -ScriptBlock $Block

Wait-Job $Job | Out-Null

# Job will be "Completed" even with file errors because we didn't re-throw
$JobResults = Receive-Job $Job
$JobResults

# ============================================================================
# KEY INSIGHT: FAIL-SAFE VS FAIL-FAST
# ============================================================================

# FAIL-FAST (Figures 4.17-4.18):
# - throw on first error
# - Job enters "Failed" state
# - Remaining items are NOT processed
# - Use when: one failure invalidates the entire operation

# FAIL-SAFE (This figure):
# - Catch errors internally
# - Job stays "Completed"
# - ALL items are processed
# - Results include both successes and failures
# - Use when: partial success is acceptable/preferred

# ============================================================================
# PRODUCTION BENEFITS OF THIS PATTERN
# ============================================================================

# 1. COMPLETE PROCESSING
#    - All files attempted, not just until first error
#    - Better for batch operations

# 2. STRUCTURED RESULTS
#    - Each item has consistent structure
#    - Easy to filter: $JobResults | Where-Object ErrorLevel -eq "Error"

# 3. PERSISTENT LOGGING
#    - JSON log file survives session end
#    - Can be shipped to log aggregation systems
#    - Historical record for debugging

# 4. EASY ANALYSIS
#    $Errors = $JobResults | Where-Object { $_.ErrorLevel -eq "Error" }
#    $Success = $JobResults | Where-Object { $_.ErrorLevel -eq "Info" }

# ============================================================================
# JSON LOG FORMAT
# ============================================================================

# Each entry in ErrorLog.json (one per line):
# {"Date":"12-01-2026 10:30:45","ErrorLevel":"Info","Message":"Content from File1.txt..."}
# {"Date":"12-01-2026 10:30:45","ErrorLevel":"Error","Message":"Failed to load..."}

# Expected Output:
# Date                ErrorLevel Message
# ----                ---------- -------
# 12-01-2026 10:30:45 Info       Content from File1.txt successfully logged: ...
# 12-01-2026 10:30:45 Info       Content from File2.txt successfully logged: ...
# 12-01-2026 10:30:45 Error      Failed to load content from NonExistingFile.txt: ...
# 12-01-2026 10:30:45 Info       Content from File3.txt successfully logged: ...
