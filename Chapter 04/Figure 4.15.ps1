class MyCustomErrorClass : System.Exception {
    # Class properties
    [string]$Message
    [int]$ErrorCode
    [string]$Stack
    [string]$Date
    [string]$ScriptName
    [bool]$CompressJson
    [ValidateSet("Ok","Debug","Info","Warning","Error","Critical")]
    [string]$Level

    # Constructor to initialize the custom properties
    MyCustomErrorClass([string]$Message, [int]$ErrorCode, [string]$Level, [string]$ScriptName, [bool]$CompressJson) :
        base($Message) {

        $this.Message = $Message
        $this.ErrorCode = $ErrorCode
        $this.Stack = [System.Environment]::StackTrace
        $this.Date = (Get-Date -Format "dd-MM-yyyy HH:mm:ss")
        $this.ScriptName = $ScriptName
        $this.CompressJson = $CompressJson
        $this.Level = $Level
    }

    # Custom method to override the ToString() method
    [string]ToString() {
        return "Date: $($this.Date) Level: $($this.Level) Message: $($this.Message) (Error Code: $($this.ErrorCode))"
    }

    # Custom method for output custom error data in JSON
    [string]Json() {
        $Obj = [PSCustomObject]@{
            Message = $this.message
            Code = $this.ErrorCode
            Level = $this.Level
            Date = $this.Date
            ScriptName = $this.ScriptName
            Server = $Env:COMPUTERNAME
            Stack = $this.Stack
        }
        if ($this.CompressJson -eq $true){
            return $Obj | ConvertTo-Json -Compress
        }
        else{
            return $Obj | ConvertTo-Json
        }
    }
}


try{
    Get-Content -Path "NonExistingFile" -ErrorAction "Stop"
}
catch{
    try{
        $ScriptName = $MyInvocation.MyCommand.Name
        throw [MyCustomErrorClass]::new($_.Exception.Message, 1101, "Error", $ScriptName, $false)
    }
    catch [MyCustomErrorClass]{
        Write-Output "Error caught: $($_.Exception.ToString())"
        $_.Exception.Json() | Out-File c:\temp\testlog.json -Append
    }
}