# Figure 4.1 - Try/Catch/Finally with Database Connection Simulation
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This example demonstrates structured error handling using try/catch/finally
# blocks with a simulated database connection class. The pattern ensures
# resources are properly cleaned up regardless of success or failure.

# ============================================================================
# DATABASE CONNECTION CLASS
# ============================================================================

# This class simulates a database connection to demonstrate error handling
# patterns without requiring an actual database server.

class DatabaseInstance {

    # Connection properties
    [string] $Server
    [string] $Database
    [array] $Databases      # Simulated list of available databases
    [bool] $Connected       # Tracks connection state for cleanup logic

    # Constructor initializes connection parameters
    # Note: Connection is NOT established here - just configured
    DatabaseInstance([string]$Server, [string]$Database) {
        $this.Server = $Server
        $this.Database = $Database
        # Simulated database catalog - represents available databases
        $this.Databases = @("Master", "TempDB", "TestDB")
        $this.Connected = $false
    }

    # Query simulation method
    # Randomly succeeds or fails to demonstrate error scenarios
    [string] Query() {
        $Rand = 1..4 | Get-Random
        # Even numbers succeed, odd numbers fail
        if ($Rand % 2 -eq 0) {
            return "Simulated query result from the database."
        }
        else {
            # Throwing from methods creates terminating errors
            throw "Query operation failed."
        }
    }

    # Connection simulation method
    # Validates database exists before "connecting"
    [string] Connect() {
        if ($this.Database -in $this.Databases) {
            $this.Connected = $true
            return "Connected to database on server $($this.Server), database $($this.Database)."
        }
        else {
            # Database not found - throw a terminating error
            throw "Could not connect to database $($this.Database)"
        }
    }

    # Close connection simulation method
    # Always succeeds in this simulation
    [string] Close() {
        return "Closed database connection to $($this.Server), $($this.Database)."
    }
}

# ============================================================================
# TRY/CATCH/FINALLY DEMONSTRATION
# ============================================================================

try {
    # TRY BLOCK: Contains code that might throw exceptions
    # All database operations go here where errors can occur

    # Instantiate the database connection object
    # Using "TestDB" which exists in our simulated catalog
    $Connection = [DatabaseInstance]::new("example-server", "TestDB")

    # Connect to the database - may throw if database doesn't exist
    $Connection.Connect()
    Write-Output "Performing database operation..."

    # Execute a query - randomly succeeds or fails
    $Result = $Connection.Query()
    Write-Output "Query result: $Result"
}
catch {
    # CATCH BLOCK: Handles any terminating error from the try block
    # The $_ automatic variable contains the error record
    Write-Output "An error occurred: $_"
}
finally {
    # FINALLY BLOCK: ALWAYS executes regardless of success or failure
    # Perfect for cleanup operations like closing connections

    # Nested try/catch handles potential cleanup errors gracefully
    try {
        if ($Connection.Connected -eq $true) {
            # Only close if we successfully connected
            $Connection.Close()
        }
        else {
            throw "Could not close non-existing connection"
        }
    }
    catch {
        # Log cleanup failures without propagating them
        Write-Output "$_"
    }
}

# ============================================================================
# KEY CONCEPTS
# ============================================================================

# TRY/CATCH/FINALLY STRUCTURE:
# - try { }     : Code that might throw exceptions
# - catch { }   : Error handling logic (only runs on error)
# - finally { } : Cleanup code (ALWAYS runs)

# WHY USE FINALLY?
# - Guaranteed execution even if catch block throws
# - Resource cleanup (connections, files, locks)
# - Restoring state (changing directories, preferences)

# ACCESSING ERROR INFORMATION:
# - $_                    : Current error record
# - $_.Exception          : The underlying .NET exception
# - $_.Exception.Message  : Error message text
# - $_.ScriptStackTrace   : PowerShell call stack
# - $_.InvocationInfo     : Details about the failing command

# Expected Output (varies due to random query):
# Performing database operation...
# Query result: Simulated query result from the database.
#
# OR (if query fails):
# Performing database operation...
# An error occurred: Query operation failed.
# Closed database connection to example-server, TestDB.
