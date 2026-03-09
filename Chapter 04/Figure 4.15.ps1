# Figure 4.15 - Wrapping Standard Errors in Custom Error Class
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows (uses C:\temp for log files)
#
# This demonstrates a powerful pattern: catching standard PowerShell errors
# and re-throwing them as custom exception types. This allows consistent
# error handling and logging regardless of the original error source.

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
# ERROR WRAPPING PATTERN
# ============================================================================

try {
    # OUTER TRY: Catches standard PowerShell errors
    # and converts them to our custom format

    Get-Content -Path "NonExistingFile" -ErrorAction "Stop"
}
catch {
    # CATCH STANDARD ERROR: Wrap in our custom exception

    try {
        $ScriptName = $MyInvocation.MyCommand.Name

        # Create custom exception using the ORIGINAL error message
        # This preserves the error information while adding our metadata
        throw [MyCustomErrorClass]::new(
            $_.Exception.Message,  # Use original error message
            1101,                  # Custom error code for file operations
            "Error",
            $ScriptName,
            $false
        )
    }
    catch [MyCustomErrorClass] {
        # Now we can handle ALL errors consistently
        Write-Output "Error caught: $($_.Exception.ToString())"
        $_.Exception.Json() | Out-File C:\temp\testlog.json -Append
    }
}

# ============================================================================
# WHY WRAP ERRORS?
# ============================================================================

# BENEFITS OF THIS PATTERN:
# 1. Consistent error format regardless of source
# 2. Custom error codes for monitoring/alerting
# 3. Structured logging (JSON) for all errors
# 4. Additional context (script name, server, timestamp)
# 5. Single error handling path for entire application

# ERROR CODE SCHEME EXAMPLE:
# 1000-1099: General errors
# 1100-1199: File operation errors
# 1200-1299: Network errors
# 1300-1399: Database errors
# 1400-1499: Authentication errors

# ============================================================================
# ALTERNATIVE: INNER EXCEPTION CHAINING
# ============================================================================

# For debugging, you might want to preserve the original exception
# as an InnerException. This requires modifying the constructor:
#
# MyCustomErrorClass([string]$Message, [int]$Code, ..., [Exception]$Inner)
#     : base($Message, $Inner) { ... }
#
# Then: throw [MyCustomErrorClass]::new($msg, 1101, ..., $_.Exception)

# Expected Output:
# Error caught: Date: 12-01-2026 10:30:45 Level: Error Message: Cannot find path '...\NonExistingFile' because it does not exist. (Error Code: 1101)
