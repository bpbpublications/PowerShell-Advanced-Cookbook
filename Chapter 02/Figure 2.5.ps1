# Figure 2.5 - Simple function with parameters and return statement
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This function demonstrates explicit return statements.
# The return keyword makes it clear what value the function outputs.

function Heroes ($Name, $Ability) {
    # The return statement explicitly specifies what the function outputs
    # This is clearer than relying on PowerShell's implicit output behavior
    return "$Name is $Ability"
}

# ============================================================================
# DEMONSTRATION: Using return values
# ============================================================================

# Method 1: Call function directly - output goes to console
Heroes -Name "Green Giant" -Ability "Smashing"

# Expected Output:
# Green Giant is Smashing

# Method 2: Capture the return value in a variable for later use
$AHero = Heroes -Name "Lightning Girl" -Ability "Creating thunder"

# The variable now contains the returned string
$AHero

# Expected Output:
# Lightning Girl is Creating thunder

# Key Concepts:
# - The 'return' keyword explicitly returns a value from the function
# - Without 'return', PowerShell returns the last expression automatically
# - Return values can be captured in variables or used directly
# - Using 'return' is a best practice for clarity and maintainability
# - A function can only return ONE value (but that value can be an array/object)
