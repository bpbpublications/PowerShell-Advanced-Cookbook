# Figure 2.10 - Changing property values in array object
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates modifying values in an array-based data structure.
# While possible, it's error-prone without named properties.

# Create an array with superhero data
$Object = @("Comet", @("Flying", "LaserEyes"), 43)

# ============================================================================
# MODIFYING ARRAY VALUES
# ============================================================================

# Add a new ability to the abilities array (index 1)
# += appends to the nested array
$Object[1] += "Indestructable"

# Change the Powers value (index 2)
$Object[2] = 50

# Verify the changes
$Object[1]    # Now: Flying, LaserEyes, Indestructable
$Object[2]    # Now: 50

# Expected Output:
# Flying
# LaserEyes
# Indestructable
# 50

# ============================================================================
# THE PROBLEM WITH ARRAYS
# ============================================================================

# What if you have 30 properties?
# - You must remember: Index 27 = Power, Index 28 = Level
# - Easy to make mistakes: $Object[28] += 10  # Oops, wrong index!
# - No intellisense or tab completion
# - Code becomes unreadable

# Key Concepts:
# - Array values CAN be modified by index
# - Nested arrays can be extended with +=
# - Index-based access is error-prone for complex data
# - PSCustomObject with named properties is much safer (see Figure 2.11)
