# Figure 4.20 - Structured Logging in Jobs (Variable Assignment)
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows (uses C:\temp for log files)
#
# This is nearly identical to Figure 4.19 but demonstrates
# explicit variable assignment when receiving job results.
# Note the correction: $JobResults = Receive-Job $Job (not separate line).
# Requires: File1.txt, File2.txt, File3.txt in current directory

# ============================================================================
# JOB WITH STRUCTURED ERROR HANDLING AND LOGGING
# ============================================================================

$Block = {
    $Files = @("File1.txt", "File2.txt", "NonExistingFile.txt", "File3.txt")

    foreach ($File in $Files) {
        # Create structured output object for consistent format
        $Data = [PSCustomObject]@{
            Date       = Get-Date -Format "dd-MM-yyyy HH:mm:ss"
            ErrorLevel = ""
            Message    = ""
        }

        try {
            $Content = Get-Content -Path $File -ErrorAction Stop
            $Data.Message = "Content from $($File) successfully logged: $($Content)"
            $Data.ErrorLevel = "Info"
        }
        catch {
            # Handle error without failing the job
            $Data.Message = "Failed to load content from $($File): $_"
            $Data.ErrorLevel = "Error"
        }

        # Write to persistent log file
        $Data | ConvertTo-Json -Compress | Out-File -FilePath "C:\temp\ErrorLog.json" -Append

        # Output for collection by Receive-Job
        $Data
    }
}

# ============================================================================
# START, WAIT, AND COLLECT RESULTS
# ============================================================================

$Job = Start-Job -ScriptBlock $Block

Wait-Job $Job | Out-Null

# Capture results in a variable for further processing
$JobResults = Receive-Job $Job

# Display results
$JobResults

# ============================================================================
# WORKING WITH JOB RESULTS
# ============================================================================

# Filter results by error level
# $Errors = $JobResults | Where-Object { $_.ErrorLevel -eq "Error" }
# $Info = $JobResults | Where-Object { $_.ErrorLevel -eq "Info" }

# Count successes and failures
# Write-Output "Successful: $($Info.Count), Failed: $($Errors.Count)"

# Export to CSV for reporting
# $JobResults | Export-Csv -Path "C:\temp\Results.csv" -NoTypeInformation

# ============================================================================
# VARIABLE ASSIGNMENT PATTERNS
# ============================================================================

# PATTERN 1: Direct assignment (this figure)
# $JobResults = Receive-Job $Job

# PATTERN 2: Piping (less common for jobs)
# $JobResults = $Job | Receive-Job

# PATTERN 3: Multiple jobs
# $AllResults = Get-Job | Receive-Job

# ============================================================================
# CLEANUP
# ============================================================================

# Always remove completed jobs to free resources
# Remove-Job $Job

# Or remove all completed jobs
# Get-Job | Where-Object State -eq "Completed" | Remove-Job

# Expected Output:
# Date                ErrorLevel Message
# ----                ---------- -------
# 12-01-2026 10:30:45 Info       Content from File1.txt successfully logged: ...
# 12-01-2026 10:30:45 Info       Content from File2.txt successfully logged: ...
# 12-01-2026 10:30:45 Error      Failed to load content from NonExistingFile.txt: ...
# 12-01-2026 10:30:45 Info       Content from File3.txt successfully logged: ...
