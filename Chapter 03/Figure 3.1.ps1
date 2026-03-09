# Figure 3.1 - Nested foreach loops for iteration
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates nested foreach loops to create a multiplication table.
# Nested loops are essential when you need to iterate over multiple dimensions
# of data, such as rows and columns in a table.

# ============================================================================
# NESTED FOREACH LOOPS
# ============================================================================

# The outer loop iterates through values 1-5 (representing rows)
# For each iteration of the outer loop, the inner loop runs completely (1-5)
# This creates a 5x5 multiplication table with 25 total iterations

foreach ($Outer in 1..5) {
    # The inner loop runs 5 times for EACH iteration of the outer loop
    # This is what makes nested loops powerful for multi-dimensional iteration
    foreach ($Inner in 1..5) {
        # String interpolation with subexpression $() for the calculation
        Write-Output "$Outer x $Inner = $($Outer * $Inner)"
    }
}

# Expected Output:
# 1 x 1 = 1
# 1 x 2 = 2
# 1 x 3 = 3
# 1 x 4 = 4
# 1 x 5 = 5
# 2 x 1 = 2
# 2 x 2 = 4
# ... (continues through 5 x 5 = 25)

# ============================================================================
# KEY CONCEPTS
# ============================================================================
# - The range operator (..) creates an array of sequential integers
# - The inner loop completes ALL iterations before the outer loop advances
# - Total iterations = Outer count x Inner count (5 x 5 = 25)
# - Nested loops are O(n*m) complexity - be mindful with large datasets
