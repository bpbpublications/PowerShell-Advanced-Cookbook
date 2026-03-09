# Figure 3.20 - Measuring parallel job performance with 4 workers
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example measures the execution time of parallel CSV processing
# with 4 workers, establishing a benchmark for comparison with different
# worker counts.

# ============================================================================
# PARALLEL CSV PROCESSING FUNCTION USING JOBS
# ============================================================================

function Process-CsvJob {
    param(
        [string]$CsvPath,
        [int]$ParallelJobs = 4
    )

    # Script block executed by each parallel job
    $ProcessRowScriptBlock = {
        param($JobNumber, $Chunk)

        $Results = @()
        foreach ($Row in $Chunk) {
            $Name = $Row.Name
            $Results += "Job $JobNumber : Processed $Name"
        }

        return $Results
    }

    # Load data in main process
    $CsvData = Import-Csv -Path $CsvPath

    # Track job objects
    $Jobs = @()

    # Divide work into chunks
    $ChunkSize = [Math]::Ceiling($CsvData.Count / $ParallelJobs)

    # Create and start parallel jobs
    for ($JobNumber = 1; $JobNumber -le $ParallelJobs; $JobNumber++) {
        $StartIndex = ($JobNumber - 1) * $ChunkSize
        $EndIndex = [Math]::Min(($StartIndex + $ChunkSize - 1), ($CsvData.Count - 1))
        $Chunk = $CsvData[$StartIndex..$EndIndex]

        $Job = Start-Job -ScriptBlock $ProcessRowScriptBlock -ArgumentList $JobNumber, $Chunk
        $Jobs += $Job
    }

    # Wait for completion, collect results, cleanup
    Wait-Job -Job $Jobs
    $Result = Receive-Job $Jobs
    Remove-Job $Jobs

    return $Result
}

# ============================================================================
# MEASURE EXECUTION TIME WITH 4 WORKERS
# ============================================================================

# Measure-Command wraps the operation and returns timing information
# This is the primary benchmark for 4-worker parallel processing
Measure-Command { Process-CsvJob -CsvPath .\organizations-100000.csv -ParallelJobs 4 }

# Uncomment to also see results:
# Process-CsvJob -CsvPath .\organizations-100000.csv -ParallelJobs 4

# Uncomment to compare with different worker counts:
# Measure-Command { Process-CsvJob -CsvPath .\organizations-100000.csv -ParallelJobs 10 }

# ============================================================================
# EXPECTED OUTPUT AND ANALYSIS
# ============================================================================

# Expected Output (timing will vary based on system):
# Days              : 0
# Hours             : 0
# Minutes           : 0
# Seconds           : 14
# Milliseconds      : 567
# Ticks             : 145670000
# TotalDays         : 0.000168599537037037
# TotalHours        : 0.00404638888888889
# TotalMinutes      : 0.242783333333333
# TotalSeconds      : 14.567
# TotalMilliseconds : 14567

# ANALYSIS:
# - 4 workers process 100,000 rows in ~15 seconds
# - Compared to sequential (~45 seconds): ~3x speedup
# - Each worker handles ~25,000 rows
# - Job startup overhead is amortized across many rows

# WHY NOT 4X SPEEDUP?
# 1. Job creation overhead (starting new processes)
# 2. Data serialization between processes
# 3. Result collection overhead
# 4. Wait-Job synchronization
# 5. Some CPU cores may be busy with other tasks

# OPTIMAL WORKER COUNT:
# - Generally equals number of CPU cores for CPU-bound work
# - Can exceed cores for I/O-bound work (waiting on disk/network)
# - Too many workers = overhead exceeds benefit
# - See Figure 3.21 for 10-worker comparison
