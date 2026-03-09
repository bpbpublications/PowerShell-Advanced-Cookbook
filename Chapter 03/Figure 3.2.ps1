# Figure 3.2 - Using break statements in nested loops
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates how the 'break' statement behaves in nested loops.
# Without labels, break only exits the INNERMOST loop containing it,
# which can lead to unexpected behavior if not understood properly.

# ============================================================================
# BREAK IN NESTED LOOPS (UNLABELED)
# ============================================================================

foreach ($Outer in 1..5) {
    foreach ($Inner in 1..5) {
        Write-Output "$Outer x $Inner = $($Outer * $Inner)"

        # This break only exits the INNER loop when Inner equals 3
        # The outer loop continues to the next iteration
        if ($Inner -eq 3) {
            break
        }
    }

    # This break exits the OUTER loop when Outer equals 3
    # Without this, the outer loop would continue through 5
    if ($Outer -eq 3) {
        break
    }
}

# Expected Output:
# 1 x 1 = 1
# 1 x 2 = 2
# 1 x 3 = 3      <- Inner loop breaks here, outer continues
# 2 x 1 = 2
# 2 x 2 = 4
# 2 x 3 = 6      <- Inner loop breaks here, outer continues
# 3 x 1 = 3
# 3 x 2 = 6
# 3 x 3 = 9      <- Inner breaks, then outer breaks (Outer -eq 3)

# ============================================================================
# KEY CONCEPTS
# ============================================================================
# - Unlabeled 'break' only exits the innermost enclosing loop
# - To exit multiple nested loops, you need multiple break conditions
#   OR use labeled breaks (see Figure 3.3 and 3.4)
# - This pattern can be error-prone; labeled breaks are clearer
