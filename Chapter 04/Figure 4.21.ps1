# Figure 4.21 - Production Logging Function with Structured JSON Output
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates a production-ready logging function that writes
# structured JSON logs with proper error handling, file management,
# and extensibility for additional context.

# ============================================================================
# LOGGING FUNCTION DEFINITION
# ============================================================================

function Add-LogToJson {
    [CmdletBinding()]
    param (
        # Path to the log file - will be created if it doesn't exist
        [Parameter(Position = 0, Mandatory = $true, HelpMessage = "Path to logfile")]
        [String]$LogFile,

        # The log message to record
        [Parameter(Position = 1, Mandatory = $true, HelpMessage = "Message String")]
        [String]$Message,

        # Severity level - defaults to INFO
        [Parameter(HelpMessage = "Severity Level")]
        [ValidateSet("INFO", "WARNING", "ERROR", "CRITICAL", "DEBUG", "OK")]
        [String]$Level = "INFO",

        # Additional key-value pairs to include in the log entry
        [Parameter(HelpMessage = "Add additional key/values in form of a hashtable")]
        [hashtable]$Adds,

        # Control JSON formatting (compress for log aggregation)
        [Parameter(HelpMessage = "Compress JSON output")]
        [switch]$Compress
    )

    BEGIN {
        # =====================================================================
        # INITIALIZATION: Ensure log file exists
        # =====================================================================

        if (-not (Test-Path $LogFile)) {
            New-Item -Path $LogFile -ItemType File -Force | Out-Null
            Write-Verbose "Logfile created: $LogFile"
        }

        # Create timestamp with millisecond precision
        $Time = Get-Date -Format "dd-MM-yyyy HH:mm:ss,fff"

        # Build the log string for verbose output
        [String]$LogString = "$Time - $Level : $Message"

        # =====================================================================
        # BUILD LOG ENTRY OBJECT
        # =====================================================================

        $Body = @{ }
        $Body.Add("timestamp", $Time)
        $Body.Add("message", $Message)
        $Body.Add("level", $Level)

        # Merge additional fields if provided
        if ($Adds) {
            $Body = $Body + $Adds
        }
    }

    PROCESS {
        # =====================================================================
        # WRITE LOG ENTRY WITH PROPER RESOURCE MANAGEMENT
        # =====================================================================

        try {
            # Use StreamWriter for better performance with frequent writes
            # Second parameter ($true) enables append mode
            $Stream = [System.IO.StreamWriter]::new($LogFile, $true)

            if ($Compress) {
                # Single-line JSON for log aggregation systems
                $Stream.WriteLine("$($Body | ConvertTo-Json -Compress)")
            }
            else {
                # Multi-line JSON for human readability
                $Stream.WriteLine("$($Body | ConvertTo-Json)")
            }

            Write-Verbose "Successfully written log to file: $LogFile"
        }
        catch {
            Write-Error "Could not create log entry: $_"
        }
        finally {
            # ALWAYS close the stream to release file handle
            try {
                $Stream.Close()
            }
            catch {
                # Ignore close errors (stream may not have been opened)
            }
        }
    }

    END {
        # Output the log string to verbose stream for debugging
        Write-Verbose $LogString
    }
}

# ============================================================================
# DEMONSTRATION: FILE PROCESSING WITH STRUCTURED LOGGING
# ============================================================================

# Enable verbose output to see logging activity
$VerbosePreference = "Continue"

$LogFile = "CustomLog.json"
$Files = @("File1.txt", "File2.txt", "NonExistingFile.txt", "File3.txt")

foreach ($File in $Files) {
    try {
        $Content = Get-Content -Path $File -ErrorAction Stop
        $Message = "Content from $($File) successfully extracted: $($Content)"

        # Log success - just message and default INFO level
        Add-LogToJson $LogFile $Message
    }
    catch {
        $Message = "Failed to load content from $($File)"

        # Log failure with additional context for debugging
        $AddInfo = @{
            "errormessage" = $_.Exception.Message
            "stacktrace"   = $_.Exception.StackTrace
            "file"         = $File
            "filepath"     = (Get-Location).Path
        }

        Add-LogToJson $LogFile $Message -Level ERROR -Adds $AddInfo
    }
}

# ============================================================================
# KEY FEATURES OF THIS LOGGING FUNCTION
# ============================================================================

# 1. AUTO-CREATE LOG FILE
#    - Creates file if it doesn't exist
#    - Continues working if file already exists

# 2. STRUCTURED OUTPUT
#    - JSON format for log aggregation
#    - Consistent fields: timestamp, message, level
#    - Extensible via -Adds parameter

# 3. ERROR CONTEXT
#    - -Adds allows attaching any key-value data
#    - Include exception details, stack traces, file paths

# 4. PROPER RESOURCE MANAGEMENT
#    - StreamWriter for performance
#    - finally block ensures file handle is released

# 5. VERBOSITY CONTROL
#    - Verbose output for debugging
#    - Silent operation in production

# Expected Output (verbose):
# VERBOSE: Logfile created: CustomLog.json
# VERBOSE: Successfully written log to file: CustomLog.json
# VERBOSE: 12-01-2026 10:30:45,123 - INFO : Content from File1.txt...
# ...

# Expected Log File Contents:
# {"timestamp":"12-01-2026 10:30:45,123","message":"Content from File1.txt...","level":"INFO"}
# {"timestamp":"12-01-2026 10:30:45,125","message":"Failed to load...","level":"ERROR","errormessage":"...","stacktrace":"...","file":"NonExistingFile.txt","filepath":"..."}
