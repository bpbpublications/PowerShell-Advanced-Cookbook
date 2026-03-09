# Figure 3.4 - Labeled break to exit the outer loop
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates using 'break' with a label to exit an OUTER loop
# from within an inner loop. This is the key difference from Figure 3.3.

# ============================================================================
# LABELED BREAK - EXITING OUTER LOOP FROM INNER
# ============================================================================

:OuterLoop foreach ($Outer in 1..3) {
    Write-Host "Outer Loop: $Outer"

    :InnerLoop foreach ($Inner in 1..3) {
        Write-Host "Inner Loop: $Inner"

        # When both conditions are met, break out of the OUTER loop entirely
        # This terminates both loops immediately
        if ($Outer -eq 2 -and $Inner -eq 2) {
            Write-Host "Breaking out of the outer loop..."
            break OuterLoop  # Exits the outer loop, not just the inner
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
# Breaking out of the outer loop...   <- Both loops terminate here

# Notice: "Outer Loop: 3" never appears because we broke out of OuterLoop

# ============================================================================
# KEY CONCEPTS
# ============================================================================
# - 'break OuterLoop' from inside InnerLoop exits BOTH loops
# - This is how you can "break out of multiple levels" of nesting
# - Without labels, you would need multiple break statements and
#   additional flag variables to achieve the same result
# - Labeled breaks make complex flow control cleaner and more maintainable
