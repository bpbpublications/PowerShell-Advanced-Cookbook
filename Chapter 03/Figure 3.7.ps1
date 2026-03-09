# Figure 3.7 - Labeled continue targeting the outer loop
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates using 'continue' with a label to skip to the
# next iteration of an OUTER loop from within an inner loop. This is
# fundamentally different from Figure 3.6 - the inner loop is abandoned.

# ============================================================================
# LABELED CONTINUE - TARGETING OUTER LOOP
# ============================================================================

:OuterLoop foreach ($Outer in 1..3) {
    Write-Host "Outer Loop: $Outer"

    :InnerLoop foreach ($Inner in 1..3) {
        # When Inner equals 2, skip to the next iteration of OUTERLOOP
        # This abandons the rest of InnerLoop AND moves OuterLoop forward
        if ($Inner -eq 2) {
            Write-Host "Continuing next iteration of the outer loop..."
            continue OuterLoop  # Skips to next Outer, abandoning Inner
        }

        Write-Host "Inner Loop: $Inner"
    }
}

# Expected Output:
# Outer Loop: 1
# Inner Loop: 1
# Continuing next iteration of the outer loop...  <- Inner = 3 never runs!
# Outer Loop: 2
# Inner Loop: 1
# Continuing next iteration of the outer loop...  <- Inner = 3 never runs!
# Outer Loop: 3
# Inner Loop: 1
# Continuing next iteration of the outer loop...  <- Inner = 3 never runs!

# Notice: "Inner Loop: 3" never appears - the outer loop advances before
#         the inner loop can reach its third iteration

# ============================================================================
# KEY CONCEPTS
# ============================================================================
# - 'continue OuterLoop' from InnerLoop skips BOTH to OuterLoop's next
# - The remaining InnerLoop iterations are abandoned (Inner = 3 never runs)
# - This is powerful for "early exit" patterns in nested structures
# - Use case: Stop processing inner items when a condition is met,
#   but continue with the next batch in the outer loop
