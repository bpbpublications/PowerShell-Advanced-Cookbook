# Figure 4.14 - Custom Error Class with Compressed JSON Output
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows (uses C:\temp for log files)
#
# This example is similar to Figures 4.12-4.13 but demonstrates
# the compressed JSON output option (CompressJson = $true), which
# is preferred for log aggregation systems like ELK, Splunk, or Azure.

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
# DEMONSTRATION WITH COMPRESSED JSON
# ============================================================================

try {
    $ScriptName = $MyInvocation.MyCommand.Name

    # Note: CompressJson = $true for single-line JSON output
    # This format is optimal for log aggregation systems
    throw [MyCustomErrorClass]::new(
        "This is a custom error message.",
        1001,
        "Error",
        $ScriptName,
        $true  # COMPRESSED JSON - single line output
    )
}
catch [MyCustomErrorClass] {
    Write-Output "Error caught: $($_.Exception.ToString())"
    $_.Exception.Json() | Out-File C:\temp\testlog.json -Append
}

# ============================================================================
# COMPRESSED VS UNCOMPRESSED JSON
# ============================================================================

# COMPRESSED ($true) - Single line, ideal for log systems:
# {"Message":"Error message","Code":1001,"Level":"Error","Date":"12-01-2026 10:30:45",...}

# UNCOMPRESSED ($false) - Multi-line, human readable:
# {
#   "Message": "Error message",
#   "Code": 1001,
#   "Level": "Error",
#   "Date": "12-01-2026 10:30:45",
#   ...
# }

# WHY COMPRESSED?
# - One log entry per line (easier parsing)
# - Smaller file sizes
# - Compatible with log shipping tools
# - Standard format for ELK, Splunk, etc.

# Expected Output:
# Error caught: Date: 12-01-2026 10:30:45 Level: Error Message: This is a custom error message. (Error Code: 1001)
# (Compressed JSON written to C:\temp\testlog.json)
