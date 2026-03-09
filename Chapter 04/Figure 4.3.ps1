# Figure 4.3 - Connection Failure Scenario with Try/Catch/Finally
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This example demonstrates error handling when the initial connection fails.
# Unlike Figures 4.1-4.2, this uses a non-existent database to trigger
# an early failure, showing how finally handles incomplete operations.

# ============================================================================
# DATABASE CONNECTION CLASS
# ============================================================================

class DatabaseInstance {

    [string] $Server
    [string] $Database
    [array] $Databases
    [bool] $Connected

    DatabaseInstance([string]$Server, [string]$Database) {
        $this.Server = $Server
        $this.Database = $Database
        $this.Databases = @("Master", "TempDB", "TestDB")
        $this.Connected = $false
    }

    [string] Query() {
        $Rand = 1..4 | Get-Random
        if ($Rand % 2 -eq 0) {
            return "Simulated query result from the database."
        }
        else {
            throw "Query operation failed."
        }
    }

    [string] Connect() {
        if ($this.Database -in $this.Databases) {
            $this.Connected = $true
            return "Connected to database on server $($this.Server), database $($this.Database)."
        }
        else {
            throw "Could not connect to database $($this.Database)"
        }
    }

    [string] Close() {
        return "Closed database connection to $($this.Server), $($this.Database)."
    }
}

# ============================================================================
# CONNECTION FAILURE DEMONSTRATION
# ============================================================================

# Using "NonExistingDB" which is NOT in the Databases array
# This guarantees Connect() will throw an error

try {
    # Instantiate with an INVALID database name
    $Connection = [DatabaseInstance]::new("example-server", "NonExistingDB")

    # This WILL FAIL - "NonExistingDB" is not in the catalog
    # Execution jumps immediately to the catch block
    $Connection.Connect()

    # These lines NEVER execute when Connect() fails
    Write-Output "Performing database operation..."
    $Result = $Connection.Query()
    Write-Output "Query result: $Result"
}
catch {
    # Handles the connection failure
    Write-Output "An error occurred: $_"
}
finally {
    # ALWAYS executes - but now we must handle the case
    # where connection was never established

    try {
        if ($Connection.Connected -eq $true) {
            # This branch WON'T execute - we never connected
            $Connection.Close()
        }
        else {
            # This WILL execute - Connected is still $false
            throw "Could not close non-existing connection"
        }
    }
    catch {
        # Reports that we couldn't close because we never connected
        Write-Output "$_"
    }
}

# ============================================================================
# EXECUTION FLOW ANALYSIS
# ============================================================================

# WITH NON-EXISTENT DATABASE:
# 1. Constructor succeeds (just creates object)
# 2. Connect() throws immediately
# 3. "Performing database operation..." NEVER runs
# 4. Query() NEVER runs
# 5. catch block outputs the error
# 6. finally block runs:
#    - Connected is $false (never connected)
#    - Throws "Could not close non-existing connection"
#    - Inner catch handles this gracefully

# KEY INSIGHT:
# The finally block's conditional check (if $Connection.Connected)
# prevents calling Close() on a connection that was never established.
# This pattern is essential for robust resource cleanup.

# BEST PRACTICE:
# Always check resource state before cleanup. Don't assume
# operations succeeded just because the try block started.

# Expected Output:
# An error occurred: Could not connect to database NonExistingDB
# Could not close non-existing connection
