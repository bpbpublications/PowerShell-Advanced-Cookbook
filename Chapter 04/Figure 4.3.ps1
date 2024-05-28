
class DatabaseInstance {
    
    [string] $Server
    [string] $Database
    [array] $Databases
    [bool] $Connected
    
    # Constructor
    DatabaseInstance([string]$Server, [string]$Database) {
        $this.Server = $Server
        $this.Database = $Database
        $this.Databases = @("Master", "TempDB", "TestDB" )
        $this.Connected = $false

    }
    # Query simulation method
    [string] Query() {
        $Rand = 1..4 | Get-Random
        if ($Rand%2 -eq 0){
            return "Simulated query result from the database."
        }
        else{
            throw "Query operation failed."
        }
    }
    # Connection simulation method
    [string] Connect() {
        if ($this.database -in $this.Databases){
            $this.Connected = $true
            return "Connected to database on server $($this.server), database $($this.Database)."
        }
        else{
            throw "Could not connect to database $($this.Database)"
        }
    }
    # Close connection simulation method
    [string] Close() {
        return "Closed database connection to $($this.Server), $($this.Database)."
    }
}



try {
    # Instantiate the database connection object
    $Connection = [DatabaseInstance]::new("example-server", "NonExistingDB")

    # Connect to the database
    $Connection.Connect()
    Write-Output "Performing database operation..."
    # Creating a database query
    $Result = $Connection.Query()
    Write-Output "Query result: $Result"

}
catch {
    # Handle potential error
    Write-Output "An error occurred: $_"
}
finally {
    # Ensure the connection is closed, regardless of whether an error occurred or not
    try{
        if ($Connection.Connected -eq $true){
            $Connection.Close()
        }
        else{
            throw "Could not close non-existing connection"
        }
    }
    catch{
        Write-Output "$_"
    }
}