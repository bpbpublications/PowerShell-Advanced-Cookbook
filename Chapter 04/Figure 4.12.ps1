# Figure 4.12 - Custom Error Class with JSON Logging
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows (uses C:\temp for log files)
#
# This demonstrates creating a custom exception class that extends
# System.Exception with additional properties and structured JSON output
# for logging and monitoring systems.

# ============================================================================
# CUSTOM ERROR CLASS DEFINITION
# ============================================================================

# Inherit from System.Exception to create a specialized error class
# This enables type-specific catching and custom error information

class MyCustomErrorClass : System.Exception {

    # =========================================================================
    # CLASS PROPERTIES
    # =========================================================================

    [string]$Message         # Human-readable error description
    [int]$ErrorCode          # Numeric error identifier for automation
    [string]$Stack           # Captured stack trace at error creation
    [string]$Date            # Timestamp when error occurred
    [string]$ScriptName      # Name of script that generated the error
    [bool]$CompressJson      # Control JSON output format
    [ValidateSet("Ok", "Debug", "Info", "Warning", "Error", "Critical")]
    [string]$Level           # Severity level for filtering/alerting

    # =========================================================================
    # CONSTRUCTOR
    # =========================================================================

    # Constructor accepts error details and initializes all properties
    # The : base($Message) calls the parent System.Exception constructor
    MyCustomErrorClass(
        [string]$Message,
        [int]$ErrorCode,
        [string]$Level,
        [string]$ScriptName,
        [bool]$CompressJson
    ) : base($Message) {

        $this.Message = $Message
        $this.ErrorCode = $ErrorCode
        # Capture the full stack trace at the moment of error creation
        $this.Stack = [System.Environment]::StackTrace
        # Timestamp with specific format for consistent logging
        $this.Date = (Get-Date -Format "dd-MM-yyyy HH:mm:ss")
        $this.ScriptName = $ScriptName
        $this.CompressJson = $CompressJson
        $this.Level = $Level
    }

    # =========================================================================
    # TOSTRING() OVERRIDE
    # =========================================================================

    # Override ToString() for human-readable output
    [string]ToString() {
        return "Date: $($this.Date) Level: $($this.Level) Message: $($this.Message) (Error Code: $($this.ErrorCode))"
    }

    # =========================================================================
    # JSON() METHOD FOR STRUCTURED LOGGING
    # =========================================================================

    # Custom method to output error data as JSON for log aggregation systems
    [string]Json() {
        $Obj = [PSCustomObject]@{
            Message    = $this.Message
            Code       = $this.ErrorCode
            Level      = $this.Level
            Date       = $this.Date
            ScriptName = $this.ScriptName
            Server     = $Env:COMPUTERNAME    # Include server name for distributed systems
            Stack      = $this.Stack
        }
        # CompressJson controls whether output is single-line (for log systems)
        # or formatted (for human reading)
        if ($this.CompressJson -eq $true) {
            return $Obj | ConvertTo-Json -Compress
        }
        else {
            return $Obj | ConvertTo-Json
        }
    }
}

# ============================================================================
# DEMONSTRATION: THROWING AND CATCHING CUSTOM ERRORS
# ============================================================================

try {
    # Get the current script name for logging context
    $ScriptName = $MyInvocation.MyCommand.Name

    # Throw our custom exception with detailed information
    # CompressJson = $false for readable output in this demo
    throw [MyCustomErrorClass]::new(
        "This is a custom error message.",  # Message
        1001,                                # ErrorCode
        "Error",                             # Level
        $ScriptName,                         # ScriptName
        $false                               # CompressJson
    )
}
catch [MyCustomErrorClass] {
    # Type-specific catch - only catches our custom exception type
    Write-Output "Error caught: $($_.Exception.ToString())"

    # Write JSON to log file for later analysis
    $_.Exception.Json() | Out-File C:\temp\testlog.json -Append
}

# ============================================================================
# KEY CONCEPTS
# ============================================================================

# CUSTOM EXCEPTION BENEFITS:
# - Type-specific catching (catch [MyCustomErrorClass])
# - Additional properties (ErrorCode, Level, ScriptName)
# - Structured output (JSON for log aggregation)
# - Consistent error format across applications

# DESIGN CONSIDERATIONS:
# - Always inherit from System.Exception
# - Call base constructor with message
# - Include timestamp and context (server, script)
# - Consider log aggregation requirements (JSON format)
# - Use ValidateSet for constrained values (Level)

# Expected Output:
# Error caught: Date: 12-01-2026 10:30:45 Level: Error Message: This is a custom error message. (Error Code: 1001)
# (JSON also written to C:\temp\testlog.json)
