# Figure 4.2 - Successful Database Operation with Try/Catch/Finally
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This example shows the same database pattern as Figure 4.1, demonstrating
# how code flows through try/catch/finally when operations succeed.
# Compare with Figure 4.3 to see behavior when connection fails.

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
# SUCCESSFUL OPERATION FLOW
# ============================================================================

# Using "TestDB" which exists in our catalog - connection will succeed
# Query may still randomly fail to demonstrate error handling

try {
    # Instantiate with a VALID database name
    $Connection = [DatabaseInstance]::new("example-server", "TestDB")

    # This WILL succeed because TestDB is in the Databases array
    $Connection.Connect()
    Write-Output "Performing database operation..."

    # Query randomly succeeds/fails (50% chance each)
    $Result = $Connection.Query()
    Write-Output "Query result: $Result"
}
catch {
    # Only executes if Query() throws (random failure)
    Write-Output "An error occurred: $_"
}
finally {
    # ALWAYS executes - demonstrates cleanup after successful connect
    try {
        if ($Connection.Connected -eq $true) {
            # Connection succeeded, so we can close it
            $Connection.Close()
            Write-Output "Connection closed successfully."
        }
        else {
            throw "Could not close non-existing connection"
        }
    }
    catch {
        Write-Output "$_"
    }
}

# ============================================================================
# EXECUTION FLOW ANALYSIS
# ============================================================================

# WHEN QUERY SUCCEEDS (50% of runs):
# 1. try block executes completely
# 2. catch block is SKIPPED (no error)
# 3. finally block runs (closes connection)

# WHEN QUERY FAILS (50% of runs):
# 1. try block executes until Query() throws
# 2. catch block handles the error
# 3. finally block STILL runs (closes connection)

# KEY INSIGHT:
# Connection.Close() runs in BOTH scenarios because:
# - Connection was successfully established
# - finally block always executes
# - Connected property is true

# Expected Output (when query succeeds):
# Performing database operation...
# Query result: Simulated query result from the database.
# Connection closed successfully.

# Expected Output (when query fails):
# Performing database operation...
# An error occurred: Query operation failed.
# Connection closed successfully.
