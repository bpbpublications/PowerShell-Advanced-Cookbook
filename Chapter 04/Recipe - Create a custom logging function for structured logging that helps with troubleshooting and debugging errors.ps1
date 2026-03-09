# Recipe: Create a Custom Logging Function for Structured Logging
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates creating a production-ready logging function
# that outputs structured JSON logs, suitable for log aggregation systems
# like ELK Stack, Splunk, Azure Monitor, or CloudWatch.

# ============================================================================
# LOGGING FUNCTION DEFINITION
# ============================================================================

function Add-LogToJson {
    [CmdletBinding()]
    param (
        # Path to log file - created automatically if doesn't exist
        [Parameter(Position = 0, Mandatory = $true, HelpMessage = "Path to logfile")]
        [String]$LogFile,

        # The message to log
        [Parameter(Position = 1, Mandatory = $true, HelpMessage = "Message String")]
        [String]$Message,

        # Severity level with validation
        [Parameter(HelpMessage = "Severity Level")]
        [ValidateSet('INFO', 'WARNING', 'ERROR', 'CRITICAL', 'DEBUG', 'OK')]
        [String]$Level = 'INFO',

        # Additional context as key-value pairs
        [Parameter(HelpMessage = "Add additional key/values in form of a hashtable")]
        [hashtable]$Adds
    )

    BEGIN {
        # =====================================================================
        # FILE INITIALIZATION
        # =====================================================================

        # Create log file if it doesn't exist
        # -Force ensures parent directories are created
        if (-not (Test-Path $LogFile)) {
            New-Item -Path $LogFile -ItemType File -Force | Out-Null
            Write-Verbose "Logfile created: $LogFile"
        }

        # =====================================================================
        # BUILD LOG ENTRY
        # =====================================================================

        # Timestamp with millisecond precision for accurate sequencing
        $Time = Get-Date -Format "dd-MM-yyyy HH:mm:ss,fff"

        # Create readable log string for verbose output
        [String]$LogString = "$Time - $Level : $Message"

        # Build structured log object
        $Body = @{ }
        $Body.Add("timestamp", $Time)
        $Body.Add("message", $Message)
        $Body.Add("level", $Level)

        # Merge additional context if provided
        if ($Adds) {
            $Body = $Body + $Adds
        }
    }

    PROCESS {
        # =====================================================================
        # WRITE LOG WITH RESOURCE MANAGEMENT
        # =====================================================================

        try {
            # StreamWriter provides better performance for frequent writes
            # Second parameter enables append mode
            $Stream = [System.IO.StreamWriter]::new($LogFile, $true)

            # Write compressed JSON (one entry per line)
            $Stream.WriteLine("$($Body | ConvertTo-Json -Compress)")

            Write-Verbose "Successfully written log to file: $LogFile"
        }
        catch {
            Write-Error "Could not create log entry: $_"
        }
        finally {
            # ALWAYS release file handle
            try {
                $Stream.Close()
            }
            catch {
                # Ignore - stream may not have been opened
            }
        }
    }

    END {
        Write-Verbose $LogString
    }
}

# ============================================================================
# KEY FEATURES
# ============================================================================

# 1. STRUCTURED OUTPUT
#    - JSON format for machine parsing
#    - Compressed for log aggregation (one entry per line)
#    - Consistent fields: timestamp, message, level

# 2. EXTENSIBILITY
#    - -Adds parameter accepts any hashtable
#    - Add error details, user info, request IDs, etc.

# 3. PROPER RESOURCE MANAGEMENT
#    - StreamWriter for performance
#    - finally block ensures cleanup
#    - Auto-creates log file

# 4. VALIDATION
#    - ValidateSet ensures consistent log levels
#    - Mandatory parameters prevent incomplete logs

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

# Basic info log:
# Add-LogToJson "app.log" "User logged in"

# Warning with context:
# Add-LogToJson "app.log" "High memory usage" -Level WARNING -Adds @{memory="95%"}

# Error with full details:
# Add-LogToJson "app.log" "Database connection failed" -Level ERROR -Adds @{
#     server = "db01"
#     error = $_.Exception.Message
#     stack = $_.Exception.StackTrace
# }

# Expected Log Output (one JSON object per line):
# {"timestamp":"12-01-2026 10:30:45,123","message":"User logged in","level":"INFO"}
# {"timestamp":"12-01-2026 10:30:46,456","message":"High memory usage","level":"WARNING","memory":"95%"}
