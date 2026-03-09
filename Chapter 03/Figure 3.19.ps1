# Figure 3.19 - Parallel CSV processing with PowerShell Jobs
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates parallel processing using Start-Job to
# distribute work across multiple background jobs. Each job runs in
# its own process, enabling true parallel execution on multi-core systems.

# ============================================================================
# PARALLEL CSV PROCESSING FUNCTION USING JOBS
# ============================================================================

function Process-CsvJob {
    param(
        [string]$CsvPath,
        [int]$ParallelJobs = 4  # Number of parallel workers
    )

    # Define the script block that each job will execute
    # This runs in a SEPARATE PROCESS, not just a separate thread
    $ProcessRowScriptBlock = {
        param($JobNumber, $Chunk)

        $Results = @()
        foreach ($Row in $Chunk) {
            $Name = $Row.Name
            # Add job number to track which worker processed this row
            $Results += "Job $JobNumber : Processed $Name"
        }

        # Return results to the parent process
        return $Results
    }

    # Import the entire CSV file in the main process
    # Jobs will receive pre-loaded data chunks
    $CsvData = Import-Csv -Path $CsvPath

    # Array to track our job objects
    $Jobs = @()

    # Calculate chunk size to divide work evenly
    # [Math]::Ceiling ensures we don't lose any rows due to rounding
    $ChunkSize = [Math]::Ceiling($CsvData.Count / $ParallelJobs)

    # Create and start parallel jobs
    for ($JobNumber = 1; $JobNumber -le $ParallelJobs; $JobNumber++) {
        # Calculate array indices for this job's chunk
        $StartIndex = ($JobNumber - 1) * $ChunkSize
        $EndIndex = [Math]::Min(($StartIndex + $ChunkSize - 1), ($CsvData.Count - 1))

        # Extract the chunk for this job using array slicing
        $Chunk = $CsvData[$StartIndex..$EndIndex]

        # Start-Job launches a new PowerShell process
        # -ScriptBlock: The code to execute
        # -ArgumentList: Parameters passed to the script block
        $Job = Start-Job -ScriptBlock $ProcessRowScriptBlock -ArgumentList $JobNumber, $Chunk
        $Jobs += $Job
    }

    # Wait for ALL jobs to complete before continuing
    # This blocks until every job finishes
    Wait-Job -Job $Jobs

    # Collect results from all completed jobs
    # Receive-Job retrieves the output returned by each job
    $Result = Receive-Job $Jobs

    # Clean up job objects to free resources
    # Important: Jobs persist until explicitly removed
    Remove-Job $Jobs

    return $Result
}

# ============================================================================
# EXECUTE AND DISPLAY RESULTS
# ============================================================================

# Process with 4 parallel workers and show output
Process-CsvJob -CsvPath .\organizations-100000.csv -ParallelJobs 4

# Uncomment to measure execution time instead:
# Measure-Command { Process-CsvJob -CsvPath .\organizations-100000.csv -ParallelJobs 4 }

# Uncomment to compare different worker counts:
# Measure-Command { Process-CsvJob -CsvPath .\organizations-100000.csv -ParallelJobs 10 }

# ============================================================================
# KEY CONCEPTS DEMONSTRATED
# ============================================================================
# - Start-Job creates a new PowerShell PROCESS (not thread)
# - Each job runs independently and in parallel
# - Data must be passed explicitly via -ArgumentList
# - Jobs don't share memory with the parent process
# - Wait-Job blocks until specified jobs complete
# - Receive-Job retrieves output from completed jobs
# - Remove-Job cleans up job resources

# PERFORMANCE NOTES:
# - Jobs have significant startup overhead (new process per job)
# - Best for CPU-intensive or long-running tasks
# - Diminishing returns beyond number of CPU cores
# - Data serialization adds overhead for large chunks

# Expected Output (sample):
# Job 1 : Processed Acme Corp
# Job 1 : Processed Beta Inc
# Job 2 : Processed Gamma LLC
# ...

# COMPARISON WITH SEQUENTIAL (Figure 3.18):
# | Workers | Time (approx) | Speedup |
# |---------|---------------|---------|
# | 1 (seq) | 45 seconds    | 1x      |
# | 4 jobs  | 15 seconds    | 3x      |
# | 10 jobs | 12 seconds    | 3.75x   |
