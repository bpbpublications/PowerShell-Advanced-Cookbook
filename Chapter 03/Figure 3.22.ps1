# Figure 3.22 - ForEach-Object -Parallel for modern parallel processing
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications
# Requires: PowerShell 7.0 or later

# This example demonstrates ForEach-Object -Parallel, introduced in
# PowerShell 7, which provides a simpler syntax for parallel processing
# compared to Start-Job. It uses threads instead of processes, reducing
# overhead significantly.

# ============================================================================
# TEST URLs FOR PARALLEL WEB REQUESTS
# ============================================================================

$Urls = @(
    "https://www.bpb.com",
    "https://www.example.com",
    "https://www.google.com",
    "https://www.microsoft.com",
    "https://www.openai.com",
    "https://www.github.com",
    "https://www.apple.com",
    "https://www.amazon.com",
    "https://www.twitter.com",
    "https://www.reddit.com",
    "https://www.yahoo.com",
    "https://www.wikipedia.org",
    "https://www.nytimes.com",
    "https://www.bing.com",
    "https://www.instagram.com",
    "https://www.ebay.com",
    "https://www.cnn.com",
    "https://www.espn.com",
    "https://www.weather.com",
    "https://www.twitch.tv",
    "https://www.youtube.com"
)

# ============================================================================
# SEQUENTIAL PROCESSING (BASELINE)
# ============================================================================

function Measure-ResponseTimeSequential {
    param (
        [string[]]$Urls
    )

    # Process each URL one at a time
    # Each request must complete before the next begins
    $Urls | ForEach-Object {
        Invoke-WebRequest $_
    }
}

# ============================================================================
# PARALLEL PROCESSING WITH FOREACH-OBJECT -PARALLEL
# ============================================================================

function Measure-ResponseTimeParallel {
    param (
        [string[]]$Urls
    )

    # -Parallel processes multiple URLs simultaneously
    # Default throttle limit is 5 concurrent operations
    # Uses runspaces (threads) instead of processes
    $Urls | ForEach-Object -Parallel {
        Invoke-WebRequest $_
    }
}

# ============================================================================
# BENCHMARK COMPARISON
# ============================================================================

# Measure sequential processing time
$ElapsedTimeSequential = Measure-Command {
    Measure-ResponseTimeSequential -Urls $Urls
}
Write-Output "Results - Sequential processing:
$($ElapsedTimeSequential.TotalMilliseconds) Ms"

# Measure parallel processing time
$ElapsedTimeParallel = Measure-Command {
    Measure-ResponseTimeParallel -Urls $Urls
}
Write-Output "Results - Parallel processing:
$($ElapsedTimeParallel.TotalMilliseconds) Ms"

# ============================================================================
# EXPECTED OUTPUT AND ANALYSIS
# ============================================================================

# Expected Output (times vary based on network conditions):
# Results - Sequential processing:
# 12500 Ms
#
# Results - Parallel processing:
# 2800 Ms

# SPEEDUP ANALYSIS:
# - 21 URLs processed
# - Sequential: ~12.5 seconds (each request waits for previous)
# - Parallel: ~2.8 seconds (5 requests at a time by default)
# - Speedup: ~4.5x

# ============================================================================
# KEY CONCEPTS: FOREACH-OBJECT -PARALLEL
# ============================================================================
# - Introduced in PowerShell 7.0
# - Uses runspaces (threads) instead of processes (jobs)
# - Lower overhead than Start-Job
# - Default ThrottleLimit: 5 concurrent operations
# - Syntax: collection | ForEach-Object -Parallel { script block }

# THROTTLE LIMIT CONTROL:
# $Urls | ForEach-Object -Parallel { Invoke-WebRequest $_ } -ThrottleLimit 10

# ACCESSING EXTERNAL VARIABLES:
# $using: prefix is required to access variables from parent scope
# $ExternalVar = "Hello"
# 1..5 | ForEach-Object -Parallel { Write-Output "$using:ExternalVar $_" }

# ============================================================================
# COMPARISON: START-JOB VS FOREACH-OBJECT -PARALLEL
# ============================================================================
# | Feature              | Start-Job        | ForEach-Object -Parallel |
# |---------------------|------------------|--------------------------|
# | PowerShell Version  | 2.0+             | 7.0+                     |
# | Execution Unit      | Process          | Thread (Runspace)        |
# | Startup Overhead    | High             | Low                      |
# | Memory Usage        | Higher           | Lower                    |
# | Variable Access     | -ArgumentList    | $using: prefix           |
# | Syntax Complexity   | More complex     | Simpler                  |
# | Best For            | Long-running     | Many short operations    |

# IDEAL USE CASES FOR -PARALLEL:
# - Web requests (I/O-bound, lots of waiting)
# - File operations across multiple files
# - Processing many small items
# - When PowerShell 7+ is available
