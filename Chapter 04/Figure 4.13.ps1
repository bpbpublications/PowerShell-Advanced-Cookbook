# Figure 4.13 - Custom Error Class (Identical to 4.12)
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows (uses C:\temp for log files)
#
# This example is identical to Figure 4.12, demonstrating the same
# custom exception class pattern. See Figure 4.12 for detailed comments.
# Included here for continuity with the book's figure numbering.

# ============================================================================
# CUSTOM ERROR CLASS DEFINITION
# ============================================================================

class MyCustomErrorClass : System.Exception {

    [string]$Message
    [int]$ErrorCode
    [string]$Stack
    [string]$Date
    [string]$ScriptName
    [bool]$CompressJson
    [ValidateSet("Ok", "Debug", "Info", "Warning", "Error", "Critical")]
    [string]$Level

    MyCustomErrorClass(
        [string]$Message,
        [int]$ErrorCode,
        [string]$Level,
        [string]$ScriptName,
        [bool]$CompressJson
    ) : base($Message) {
        $this.Message = $Message
        $this.ErrorCode = $ErrorCode
        $this.Stack = [System.Environment]::StackTrace
        $this.Date = (Get-Date -Format "dd-MM-yyyy HH:mm:ss")
        $this.ScriptName = $ScriptName
        $this.CompressJson = $CompressJson
        $this.Level = $Level
    }

    [string]ToString() {
        return "Date: $($this.Date) Level: $($this.Level) Message: $($this.Message) (Error Code: $($this.ErrorCode))"
    }

    [string]Json() {
        $Obj = [PSCustomObject]@{
            Message    = $this.Message
            Code       = $this.ErrorCode
            Level      = $this.Level
            Date       = $this.Date
            ScriptName = $this.ScriptName
            Server     = $Env:COMPUTERNAME
            Stack      = $this.Stack
        }
        if ($this.CompressJson -eq $true) {
            return $Obj | ConvertTo-Json -Compress
        }
        else {
            return $Obj | ConvertTo-Json
        }
    }
}

# ============================================================================
# DEMONSTRATION
# ============================================================================

try {
    $ScriptName = $MyInvocation.MyCommand.Name
    throw [MyCustomErrorClass]::new(
        "This is a custom error message.",
        1001,
        "Error",
        $ScriptName,
        $false  # Pretty-printed JSON
    )
}
catch [MyCustomErrorClass] {
    Write-Output "Error caught: $($_.Exception.ToString())"
    $_.Exception.Json() | Out-File C:\temp\testlog.json -Append
}

# Expected Output:
# Error caught: Date: 12-01-2026 10:30:45 Level: Error Message: This is a custom error message. (Error Code: 1001)
