# Recipe: Use Try-Catch-Finally Blocks to Handle Errors and Ensure Reliability
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates proper use of try/catch/finally for robust
# error handling, including cleanup operations and handling connection
# scenarios where resources must be released regardless of success.

# ============================================================================
# DATABASE CONNECTION CLASS
# ============================================================================

# This class simulates database operations to demonstrate error handling
# without requiring an actual database connection

class DatabaseInstance {

    [string] $Server
    [string] $Database
    [array] $Databases       # Simulated available databases
    [bool] $Connected        # Tracks connection state

    # Constructor - initializes but does NOT connect
    DatabaseInstance([string]$Server, [string]$Database) {
        $this.Server = $Server
        $this.Database = $Database
        $this.Databases = @("Master", "TempDB", "TestDB")
        $this.Connected = $false
    }

    # Query simulation - randomly succeeds or fails
    [string] Query() {
        $Rand = 1..4 | Get-Random
        if ($Rand % 2 -eq 0) {
            return "Simulated query result from the database."
        }
        else {
            throw "Query operation failed."
        }
    }

    # Connection simulation - validates database exists
    [string] Connect() {
        if ($this.Database -in $this.Databases) {
            $this.Connected = $true
            return "Connected to database on server $($this.Server), database $($this.Database)."
        }
        else {
            throw "Could not connect to database $($this.Database)"
        }
    }

    # Close connection
    [string] Close() {
        return "Closed database connection to $($this.Server), $($this.Database)."
    }
}

# ============================================================================
# EXAMPLE 1: FAILED CONNECTION WITH CLEANUP
# ============================================================================

# This demonstrates handling a connection failure
# The finally block handles cleanup even when connection fails

try {
    # Instantiate with a NON-EXISTENT database
    $Connection = [DatabaseInstance]::new("example-server", "NonExistingDB")

    # This will FAIL - database doesn't exist
    $Connection.Connect()
    Write-Output "Performing database operation..."

    $Result = $Connection.Query()
    Write-Output "Query result: $Result"
}
catch {
    # Handle the connection error
    Write-Output "An error occurred: $_"
}
finally {
    # ALWAYS runs - must handle case where connection never succeeded

    try {
        if ($Connection.Connected -eq $true) {
            $Connection.Close()
        }
        else {
            # Connection was never established
            throw "Could not close non-existing connection"
        }
    }
    catch {
        Write-Output "$_"
    }
}

# ============================================================================
# EXAMPLE 2: UNHANDLED ERROR OUTSIDE TRY/CATCH
# ============================================================================

# This demonstrates what happens when errors occur OUTSIDE try/catch
# The error terminates execution (if ErrorActionPreference is Stop)

$Connection = [DatabaseInstance]::new("example-server", "NonExistingDB")

# This throws without any try/catch - script terminates here
$Connection.Connect()

# This will NEVER execute
Write-Output "Will not run"

# ============================================================================
# KEY CONCEPTS: RELIABLE CLEANUP
# ============================================================================

# THE FINALLY GUARANTEE:
# finally blocks run even if:
# - try block succeeds completely
# - try block throws an exception
# - catch block throws an exception
# - return statement exits the function

# PROPER CLEANUP PATTERN:
# 1. Check resource state before cleanup
# 2. Handle cleanup errors gracefully
# 3. Don't let cleanup errors mask original errors

# COMMON CLEANUP SCENARIOS:
# - Close database connections
# - Release file handles
# - Restore working directory
# - Reset $ErrorActionPreference
# - Remove temporary files
# - Release locks/mutexes

# ============================================================================
# BEST PRACTICES
# ============================================================================

# 1. ALWAYS USE TRY/CATCH IN PRODUCTION SCRIPTS
#    $ErrorActionPreference = "Stop"
#    try { ... } catch { ... } finally { ... }

# 2. CHECK RESOURCE STATE BEFORE CLEANUP
#    if ($Connection.Connected) { $Connection.Close() }

# 3. WRAP CLEANUP IN NESTED TRY/CATCH
#    finally {
#        try { $stream.Close() }
#        catch { Write-Warning "Cleanup failed: $_" }
#    }

# 4. LOG BUT DON'T THROW FROM FINALLY
#    Throwing from finally can mask the original error

# 5. CONSIDER USING -ErrorAction STOP
#    Ensures non-terminating errors are caught by try/catch

# Expected Output (Example 1):
# An error occurred: Could not connect to database NonExistingDB
# Could not close non-existing connection

# Expected Output (Example 2):
# Exception: Could not connect to database NonExistingDB
# (Script terminates)
