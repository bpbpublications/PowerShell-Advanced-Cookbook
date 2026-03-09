# Figure 2.1 - Simple function without arguments and return statement
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This is the simplest form of a function in PowerShell. It takes no arguments
# and does not explicitly return anything (void function).

# In PowerShell, any expression or command that isn't captured or redirected
# will automatically be sent to output. To create a true "void" function,
# we must suppress this behavior.

function Comet {
    # The string is piped to Out-File to prove the function did work
    # Then piped to Out-Null to suppress any return value
    # This ensures the function is truly "void" - it does work but returns nothing
    "Comet is Flying" | Out-File -FilePath C:\Temp\Superhero\Comet.txt | Out-Null
}

# Call the function - notice no output is displayed
Comet

# Expected Result:
# - No console output (function is void)
# - A file is created at C:\Temp\Superhero\Comet.txt containing "Comet is Flying"

# Verify the file was created (uncomment to test):
# Get-Content C:\Temp\Superhero\Comet.txt

# Key Concepts:
# - Functions are declared with the 'function' keyword
# - Use Verb-Noun naming convention (though 'Comet' is simplified for demo)
# - Out-Null suppresses output, making a function truly void
# - Without Out-Null, the last expression would be returned automatically
