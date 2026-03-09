# Figure 2.3 - Simple function with parameters
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This function demonstrates how to add parameters to a function.
# Parameters make functions flexible and reusable with different inputs.

function SuperHero ($Name, $Ability) {
    # String interpolation combines the parameter values
    # Output is written to a file and suppressed from console
    "$Name is $Ability" | Out-File -FilePath C:\Temp\Superhero\Superheroes.txt -Append | Out-Null
}

# ============================================================================
# DEMONSTRATION: Creating multiple superheroes with different arguments
# ============================================================================

# Call the function with different arguments each time
SuperHero -Name "Green Giant" -Ability "Smashing"
SuperHero -Name "Lightning Girl" -Ability "Creating thunder"

# Expected Result:
# The file C:\Temp\Superhero\Superheroes.txt will contain:
# Green Giant is Smashing
# Lightning Girl is Creating thunder

# You can also use positional parameters (order matters):
# SuperHero "Speed Demon" "Running fast"

# Key Concepts:
# - Parameters are defined in parentheses after the function name
# - This is the "simple" parameter syntax (vs. param block)
# - Parameters can be passed by name (-Name "value") or position
# - The -Append switch adds to the file instead of overwriting
