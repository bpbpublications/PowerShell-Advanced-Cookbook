# Figure 2.9 - Calling values in array object
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates using a simple array to store superhero data.
# While arrays work, they have limitations compared to PSCustomObject.

# Create an array with superhero data
# Index 0: Name, Index 1: Abilities (nested array), Index 2: Powers
$Object = @("Comet", @("Flying", "LaserEyes"), 43)

# Display the entire array
$Object

# Expected Output:
# Comet
# Flying
# LaserEyes
# 43

# ============================================================================
# ACCESSING VALUES BY INDEX
# ============================================================================

# Access individual elements using array indexing
$Object[0]    # Name: "Comet"
$Object[1]    # Abilities: @("Flying", "LaserEyes")
$Object[2]    # Powers: 43

# Access nested array elements
$Object[1][0]  # First ability: "Flying"
$Object[1][1]  # Second ability: "LaserEyes"

# Key Concepts:
# - Arrays use numeric indices starting at 0
# - Nested arrays can store multi-valued properties
# - You must remember what each index represents
# - No property names make code harder to read and maintain
# - Compare this to PSCustomObject in Figure 2.11 for a better approach
