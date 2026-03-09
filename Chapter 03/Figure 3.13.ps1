# Figure 3.13 - Memory usage comparison: Variable vs Pipeline processing
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows only (uses WIN32_PROCESS CIM class)

# This example demonstrates the memory efficiency difference between
# loading an entire file into a variable versus using pipeline streaming.
# Understanding this difference is crucial for processing large files.

# ============================================================================
# MEMORY MEASUREMENT FUNCTION
# ============================================================================

function Get-MemoryUsage {
    param(
        [scriptblock]$Block
    )

    # Capture memory BEFORE executing the script block
    # WorkingSetSize is the amount of memory in use by the process
    $BeforeMemory = (Get-CimInstance WIN32_PROCESS |
        Where-Object { $_.ProcessID -eq $PID }).WorkingSetSize

    # Execute the script block
    & $Block

    # Capture memory AFTER executing the script block
    $AfterMemory = (Get-CimInstance WIN32_PROCESS |
        Where-Object { $_.ProcessID -eq $PID }).WorkingSetSize

    # Calculate the difference (memory consumed by the operation)
    $MemoryUsed = $AfterMemory - $BeforeMemory

    # Display result in megabytes for readability
    Write-Output "Memory Usage: $($MemoryUsed / 1MB) MB"
}

# ============================================================================
# APPROACH 1: VARIABLE-BASED (LOADS ENTIRE FILE INTO MEMORY)
# ============================================================================

$VariableBlock = {
    $Count = 0
    # Get-Content without pipeline loads ENTIRE file into $Data
    # For a 13MB CSV, this consumes significant memory
    $Data = Get-Content .\organizations-100000.csv

    # Then iterate over the in-memory array
    foreach ($Item in $Data) {
        $Count++
    }
}

# ============================================================================
# APPROACH 2: PIPELINE-BASED (STREAMS ONE LINE AT A TIME)
# ============================================================================

$PipelinedBlock = {
    $Count = 0
    # Pipeline streams one line at a time - minimal memory footprint
    # Each line is processed and discarded before the next is read
    Get-Content .\organizations-100000.csv | ForEach-Object { $Count++ }
}

# ============================================================================
# EXECUTE AND COMPARE
# ============================================================================

Write-Output "VariableBlock:"
Get-MemoryUsage $VariableBlock

Write-Output "PipelinedBlock:"
Get-MemoryUsage $PipelinedBlock

# ============================================================================
# EXPECTED RESULTS AND KEY CONCEPTS
# ============================================================================

# Expected Output (results will vary based on file size and system):
# VariableBlock:
# Memory Usage: 45.2 MB    <- Entire file loaded into memory
# PipelinedBlock:
# Memory Usage: 0.8 MB     <- Only one line in memory at a time

# KEY CONCEPTS:
# - Variable approach: Fast access but high memory usage
#   - Good for: Small files, repeated access to data
#   - Bad for: Large files, one-time processing
#
# - Pipeline approach: Lower memory but slightly slower
#   - Good for: Large files, streaming data, one-pass processing
#   - Bad for: When you need to access data multiple times
#
# - $PID is an automatic variable containing the current process ID
# - Get-CimInstance is the modern replacement for Get-WmiObject
# - Script blocks allow passing executable code as parameters

# TRADE-OFFS:
# | Approach   | Memory    | Speed     | Best For              |
# |------------|-----------|-----------|----------------------|
# | Variable   | High      | Fast      | Small files, reuse   |
# | Pipeline   | Low       | Slower    | Large files, streams |
