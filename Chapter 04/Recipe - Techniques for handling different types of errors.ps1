# Try/Catch/Finally block
try {
    <#Code logic that might throw an exception#>
}
catch {
    <#Do this if a terminating exception happens#>
}
finally {
    <#Do this after the try block regardless of whether an exception occurred or not#>
}

##################################################################

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

##################################################################

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

##################################################################

# Create an empty array to store error objects
$ErrorArray = @()

# Example code that may cause non-terminating errors
$Files = "File1.txt", "File2.txt", "File3.txt", "File4.txt"

foreach ($File in $Files) {
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

##################################################################

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
    break
}

# Will trap all terminating errors and execute the statements inside the trap
# then will continue script execution
trap {
    Write-Host "A terminating error occurred: $($_.Exception.Message)"
    continue
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

##################################################################

$Superheroes = @("Comet", "Blue Ghost", "Evilin")

try{
    if ("Lightning Girl" -notin $Superheroes){
        throw "Lightning Girl is not yet a superhero"
    }
    Write-Output "Lightning Girl is finally a superhero"
}
catch{
    Write-Output "Error caught: $_"
}

##################################################################

$Superheroes = @("Comet", "Blue Ghost", "Evilin")

try {
    if ("Lightning Girl" -notin $Superheroes) {
        Write-Error -Message "Lightning Girl is not yet a superhero"
    }
    else {
        Write-Output "Lightning Girl is finally a superhero"
    }
    Write-Output "Another message that will shown"
}
catch {
    Write-Output "Error caught: $_"
}