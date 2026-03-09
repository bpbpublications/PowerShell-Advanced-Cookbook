# Figure 3.21 - Measuring parallel job performance with 10 workers
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example measures parallel CSV processing with 10 workers to
# demonstrate the effects of over-provisioning workers beyond CPU cores.
# Compare with Figure 3.20 (4 workers) to understand scaling behavior.

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

    # Divide work into chunks (smaller chunks with more workers)
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
# MEASURE EXECUTION TIME WITH 10 WORKERS
# ============================================================================

# Compare with Figure 3.20 which uses 4 workers
# Uncomment to see results instead of timing:
# Process-CsvJob -CsvPath .\organizations-100000.csv -ParallelJobs 4

# Uncomment to measure 4 workers:
# Measure-Command { Process-CsvJob -CsvPath .\organizations-100000.csv -ParallelJobs 4 }

# Measure 10 workers - this is the focus of this figure
Measure-Command { Process-CsvJob -CsvPath .\organizations-100000.csv -ParallelJobs 10 }

# ============================================================================
# EXPECTED OUTPUT AND SCALING ANALYSIS
# ============================================================================

# Expected Output with 10 workers:
# Days              : 0
# Hours             : 0
# Minutes           : 0
# Seconds           : 12
# Milliseconds      : 234
# Ticks             : 122340000
# TotalSeconds      : 12.234

# COMPARISON TABLE:
# | Workers | Time (approx) | Rows/Worker | Speedup vs Sequential |
# |---------|---------------|-------------|----------------------|
# | 1 (seq) | 45 sec        | 100,000     | 1.0x                 |
# | 4 jobs  | 15 sec        | 25,000      | 3.0x                 |
# | 10 jobs | 12 sec        | 10,000      | 3.75x                |

# KEY OBSERVATIONS:
# - 10 workers is only ~20% faster than 4 workers
# - Diminishing returns after exceeding CPU core count
# - Each additional worker adds startup overhead
# - Smaller chunks = more overhead for result aggregation

# WHY DIMINISHING RETURNS?
# 1. CPU cores are the limiting factor for CPU-bound work
# 2. On a 4-core system, 10 jobs compete for 4 cores
# 3. Context switching overhead increases
# 4. More processes = more memory usage
# 5. More jobs = more serialization/deserialization

# RECOMMENDATIONS:
# - For CPU-bound: workers = number of cores
# - For I/O-bound: workers = 2-4x number of cores
# - Profile with your specific workload
# - Consider ForEach-Object -Parallel (see Figure 3.22)
#   for simpler syntax and thread-based parallelism
