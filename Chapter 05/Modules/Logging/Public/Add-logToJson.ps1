# Add-LogToJson.ps1
# Module: Logging
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This public function writes log entries to a JSON file with timestamp,
# message, severity level, and optional custom fields.

function Add-LogToJson {
    <#
    .SYNOPSIS
        Writes a log entry to a JSON file.

    .DESCRIPTION
        Creates structured JSON log entries with timestamp, message, and severity level.
        Optionally adds custom fields and supports compressed (single-line) JSON output.

    .PARAMETER LogFile
        Path to the JSON log file. Created if it doesn't exist.

    .PARAMETER Message
        The log message to write.

    .PARAMETER Level
        Severity level: INFO, WARNING, ERROR, CRITICAL, DEBUG, or OK.
        Defaults to INFO.

    .PARAMETER Adds
        Hashtable of additional key/value pairs to include in the log entry.

    .PARAMETER Compress
        Output compact single-line JSON instead of formatted multi-line JSON.

    .EXAMPLE
        Add-LogToJson -LogFile "C:\Logs\app.json" -Message "Application started"

    .EXAMPLE
        Add-LogToJson -LogFile "C:\Logs\app.json" -Message "Login failed" -Level ERROR -Adds @{User="john"; IP="192.168.1.1"}
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $true, HelpMessage = "Path to logfile")]
        [String]$LogFile,

        [Parameter(Position = 1, Mandatory = $true, HelpMessage = "Message String")]
        [String]$Message,

        [Parameter(HelpMessage = "Severity Level")]
        [ValidateSet("INFO", "WARNING", "ERROR", "CRITICAL", "DEBUG", "OK")]
        [String]$Level = "INFO",

        [Parameter(HelpMessage = "Add additional key/values in form of a hashtable")]
        [Hashtable]$Adds,

        [Parameter(HelpMessage = "Compress JSON output")]
        [Switch]$Compress
    )

    BEGIN {
        # Create log file if it doesn't exist
        if (-not(Test-Path $LogFile)) {
            New-Item -Path $LogFile -ItemType File -Force | Out-Null
            Write-Verbose "Logfile created: $LogFile"
        }

        # Generate timestamp with milliseconds
        $Time = Get-Date -Format "dd-MM-yyyy HH:mm:ss,fff"
        [String]$LogString = "$Time - $Level : $Message"

        # Build the log entry hashtable
        $Body = @{ }
        $Body.Add("timestamp", $Time)
        $Body.Add("message", $Message)
        $Body.Add("level", $Level)

        # Add custom fields if provided
        if ($Adds) {
            $Body = $Body + $Adds
        }
    }

    PROCESS {
        try {
            # Use StreamWriter for better performance with large files
            $Stream = [System.IO.StreamWriter]::new($LogFile, $true)

            if ($Compress) {
                $Stream.WriteLine("$($Body | ConvertTo-Json -Compress)")
            }
            else {
                $Stream.WriteLine("$($Body | ConvertTo-Json)")
            }

            Write-Verbose "Successfully written log to file: $LogFile"
        }
        catch {
            Write-Error "Could not create log entry: $_"
        }
        finally {
            # Always close the stream
            try {
                $Stream.Close()
            }
            catch { }
        }
    }

    END {
        Write-Verbose $LogString
    }
}
