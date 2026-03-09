# Figure 3.5 - Using continue to skip iterations
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates the 'continue' statement which skips the
# remaining code in the current iteration and moves to the next iteration.
# Unlike 'break' which exits the loop entirely, 'continue' just skips ahead.

# ============================================================================
# CONTINUE IN NESTED LOOPS (UNLABELED)
# ============================================================================

foreach ($Outer in 1..3) {
    foreach ($Inner in 1..3) {
        # Skip iteration when Inner equals 2
        # The Write-Output below will NOT execute for Inner = 2
        if ($Inner -eq 2) {
            continue  # Skip to next iteration of the innermost loop
        }

        # This only executes when Inner is NOT 2
        Write-Output "$Outer x $Inner = $($Outer * $Inner)"
    }
}

# Expected Output:
# 1 x 1 = 1
#              <- 1 x 2 is skipped (continue triggered)
# 1 x 3 = 3
# 2 x 1 = 2
#              <- 2 x 2 is skipped (continue triggered)
# 2 x 3 = 6
# 3 x 1 = 3
#              <- 3 x 2 is skipped (continue triggered)
# 3 x 3 = 9

# ============================================================================
# KEY CONCEPTS
# ============================================================================
# - 'continue' skips to the NEXT iteration, unlike 'break' which exits
# - Unlabeled 'continue' affects only the innermost loop
# - The outer loop is unaffected - it runs all 3 iterations
# - Useful for filtering/skipping specific values without stopping the loop
# - See Figures 3.6 and 3.7 for labeled continue examples
