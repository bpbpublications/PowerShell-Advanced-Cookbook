# Figure 3.3 - Labeled break to exit the inner loop
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates labeled loops and how to use 'break' with a label
# to explicitly control which loop to exit. Labels make code clearer and
# allow precise control over nested loop flow.

# ============================================================================
# LABELED BREAK - EXITING INNER LOOP
# ============================================================================

# Labels are defined with a colon (:) prefix before the loop
# They provide a named target for break and continue statements

:OuterLoop foreach ($Outer in 1..3) {
    Write-Host "Outer Loop: $Outer"

    :InnerLoop foreach ($Inner in 1..3) {
        Write-Host "Inner Loop: $Inner"

        # When both conditions are met, break out of the INNER loop only
        # The outer loop will continue to its next iteration
        if ($Outer -eq 2 -and $Inner -eq 2) {
            Write-Host "Breaking out of the inner loop..."
            break InnerLoop  # Explicitly targets the inner loop
        }
    }
}

# Expected Output:
# Outer Loop: 1
# Inner Loop: 1
# Inner Loop: 2
# Inner Loop: 3
# Outer Loop: 2
# Inner Loop: 1
# Inner Loop: 2
# Breaking out of the inner loop...   <- Breaks inner, outer continues
# Outer Loop: 3
# Inner Loop: 1
# Inner Loop: 2
# Inner Loop: 3

# ============================================================================
# KEY CONCEPTS
# ============================================================================
# - Labels are prefixed with colon (:LabelName)
# - 'break LabelName' exits the specified loop
# - 'break InnerLoop' is functionally the same as unlabeled 'break' here,
#   but makes the intent explicit and code more readable
# - Compare with Figure 3.4 which uses 'break OuterLoop'
