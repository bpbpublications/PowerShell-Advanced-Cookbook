# Figure 3.6 - Labeled continue targeting the inner loop
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates using 'continue' with a label to explicitly
# target which loop should skip to its next iteration. Here we target
# the InnerLoop, which is the same as an unlabeled continue but more explicit.

# ============================================================================
# LABELED CONTINUE - TARGETING INNER LOOP
# ============================================================================

:OuterLoop foreach ($Outer in 1..3) {
    Write-Host "Outer Loop: $Outer"

    :InnerLoop foreach ($Inner in 1..3) {
        # When Inner equals 2, skip to the next iteration of InnerLoop
        # This skips the Write-Host below for Inner = 2 only
        if ($Inner -eq 2) {
            Write-Host "Continuing next iteration of the inner loop..."
            continue InnerLoop  # Explicitly targets InnerLoop
        }

        Write-Host "Inner Loop: $Inner"
    }
}

# Expected Output:
# Outer Loop: 1
# Inner Loop: 1
# Continuing next iteration of the inner loop...  <- Skips Inner = 2
# Inner Loop: 3
# Outer Loop: 2
# Inner Loop: 1
# Continuing next iteration of the inner loop...  <- Skips Inner = 2
# Inner Loop: 3
# Outer Loop: 3
# Inner Loop: 1
# Continuing next iteration of the inner loop...  <- Skips Inner = 2
# Inner Loop: 3

# ============================================================================
# KEY CONCEPTS
# ============================================================================
# - 'continue InnerLoop' skips to the next iteration of InnerLoop
# - This is equivalent to unlabeled 'continue' when inside InnerLoop
# - Using the label makes intent explicit for code readability
# - Compare with Figure 3.7 which uses 'continue OuterLoop' for
#   different behavior
