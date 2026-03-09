# Recipe: Techniques for Handling Different Types of Errors
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This comprehensive recipe covers all major error handling techniques:
# - try/catch/finally blocks
# - Type-specific exception catching
# - ErrorActionPreference and -ErrorAction
# - ErrorVariable for collecting errors
# - trap statements
# - throw and Write-Error differences

# ============================================================================
# SECTION 1: TRY/CATCH/FINALLY BASICS
# ============================================================================

# Basic structure - the foundation of PowerShell error handling
try {
    <#Code logic that might throw an exception#>
}
catch {
    <#Do this if a terminating exception happens#>
}
finally {
    <#Do this after the try block regardless of whether an exception occurred or not#>
}

# ============================================================================
# SECTION 2: TYPE-SPECIFIC EXCEPTION CATCHING
# ============================================================================

# You can catch specific exception types for targeted error handling
# More specific types should come BEFORE generic catches

try {
    # Code that might throw an exception
    $FileContent = Get-Content -Path "NonExistentFile.txt" -ErrorAction Stop
}
catch [System.Management.Automation.ItemNotFoundException] {
    # Code to handle the specific ItemNotFoundException
    Write-Output "The file was not found $($_.Exception.Message)"
}
catch {
    # Catch-all block for handling all other exceptions
    Write-Output "An unexpected exception occurred: $_"
}
finally {
    # Optional: Code that will always execute, whether an exception occurred or not
    Write-Output "Finally block executed."
}

# Code continues executing after the try-catch-finally block
Write-Output "Script execution continues after the try-catch-finally block."

# ============================================================================
# SECTION 3: ERRORACTIONPREFERENCE WITH TRY/CATCH
# ============================================================================

# Start of script
$ErrorActionPreference = "Stop"

# All subsequential commands error behavior will
# be terminating, unless else is specified

# This will explicitly be non-terminating
# suppressing display of error, and continuing script execution
Get-Content -Path "NonExistentFile.txt" -ErrorAction SilentlyContinue

# This will will result in terminating error
# and halt further script execution
Get-Content -Path "NonExistentFile.txt"

Write-Output "This will not run"

# ============================================================================
# SECTION 4: ERRORVARIABLE FOR ERROR COLLECTION
# ============================================================================

# ErrorVariable collects errors without stopping execution
# Useful for batch operations where you want to process everything
# and handle errors at the end

# Create an empty array to store error objects
$ErrorArray = @()

# Example code that may cause non-terminating errors
$Files = "File1.txt", "File2.txt", "File3.txt", "File4.txt"

foreach ($File in $Files) {
    # -ErrorVariable stores the error in $Err
    # -ErrorAction SilentlyContinue suppresses display but DOES populate ErrorVariable
    Get-Content -Path $File -ErrorVariable Err -ErrorAction SilentlyContinue

    if ($Err) {
        # Add the error object to the ErrorArray
        $ErrorArray += $Err

        # Optionally, you can perform additional error handling or logging here
        Write-Output "Error occurred while processing $File : $($Err.Exception.Message)"
    }
}

# The ErrorArray can then be inspected for all captured errors
if ($ErrorArray.Count -gt 0) {
    Write-Output "Total Errors: $($ErrorArray.Count)"
    $ErrorArray | ForEach-Object {
        Write-Output "Error Message: $($_.Exception.Message)"
    }
}

# ============================================================================
# SECTION 5: TRAP STATEMENTS
# ============================================================================

# Trap is an older error handling mechanism (PowerShell 1.0)
# Still useful in specific scenarios

# Will trap all terminating errors and execute the statements inside the trap
trap {
    Write-Host "A terminating error occurred: $($_.Exception.Message)"
}

# Will trap only errors that throws an ItemNotFoundException
# and execute the statements inside the trap
trap [System.Management.Automation.ItemNotFoundException] {
    Write-Host "A terminating error occurred: $($_.Exception.Message)"
}

# Will trap all terminating errors and execute the statements inside the trap
# then stop further script execution
trap {
    Write-Host "A terminating error occurred: $($_.Exception.Message)"
    break  # Stop script execution after handling
}

# Will trap all terminating errors and execute the statements inside the trap
# then will continue script execution
trap {
    Write-Host "A terminating error occurred: $($_.Exception.Message)"
    continue  # Resume execution after the statement that caused the error
}

# Will only trap terminating errors inside the function
# Then continue script execution inside the function.
function Get-Trap {
    trap {
        Write-Host "A terminating error occurred: $($_.Exception.Message)"
        continue
    }

    Get-Content -Path "NonExistentFile.txt" -ErrorAction Stop
}

# Will only trap terminating errors inside the function
# Then stop script execution inside the function.
function Get-Trap {
    trap {
        Write-Host "A terminating error occurred: $($_.Exception.Message)"
        break
    }

    Get-Content -Path "NonExistentFile.txt" -ErrorAction Stop
}

# ============================================================================
# SECTION 6: THROW VS WRITE-ERROR
# ============================================================================

# THROW - Creates a TERMINATING error
# Script stops unless caught by try/catch or trap

$Superheroes = @("Comet", "Blue Ghost", "Evilin")

try {
    if ("Lightning Girl" -notin $Superheroes) {
        # throw creates a terminating error
        throw "Lightning Girl is not yet a superhero"
    }
    Write-Output "Lightning Girl is finally a superhero"
}
catch {
    Write-Output "Error caught: $_"
}

# WRITE-ERROR - Creates a NON-TERMINATING error (by default)
# Script continues unless ErrorActionPreference is Stop

$Superheroes = @("Comet", "Blue Ghost", "Evilin")

try {
    if ("Lightning Girl" -notin $Superheroes) {
        # Write-Error creates NON-terminating error
        # This will NOT be caught by try/catch (unless ErrorAction Stop)
        Write-Error -Message "Lightning Girl is not yet a superhero"
    }
    else {
        Write-Output "Lightning Girl is finally a superhero"
    }
    # This line WILL execute because Write-Error is non-terminating
    Write-Output "Another message that will shown"
}
catch {
    # This catch block won't execute for Write-Error
    Write-Output "Error caught: $_"
}

# ============================================================================
# KEY CONCEPTS SUMMARY
# ============================================================================

# ERROR TYPES:
# - Terminating: Stops execution, caught by try/catch
# - Non-terminating: Displays error, continues execution

# MAKING NON-TERMINATING -> TERMINATING:
# - $ErrorActionPreference = "Stop"
# - -ErrorAction Stop on cmdlet

# WHEN TO USE WHAT:
# - try/catch/finally: Modern, recommended approach
# - trap: Legacy, simple scope-based handling
# - ErrorVariable: Batch processing, collect all errors
# - throw: Force termination, signal critical errors
# - Write-Error: Report problem but continue

# Expected Output (partial, varies by section):
# The file was not found Cannot find path...
# Finally block executed.
# Script execution continues after the try-catch-finally block.
# Error occurred while processing File1.txt : Cannot find path...
# Total Errors: 4
# Error caught: Lightning Girl is not yet a superhero
# Another message that will shown
