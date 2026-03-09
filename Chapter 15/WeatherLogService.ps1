# WeatherLogService - Windows Service Implementation
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell Studio - SAPIEN Technologies)
# Prerequisites: PowerShell Studio, Administrator privileges
#
# This is the complete source code for the WeatherLogService Windows Service.
# It demonstrates logging weather data to a JSON file periodically.

<#
    .NOTES
    ===========================================================================
     Created with:  SAPIEN Technologies, Inc., PowerShell Studio 2023 v5.8.235
     Created on:    09-01-2024 19:42
     Created by:    Morten Hansen
    ===========================================================================
    .DESCRIPTION
        Windows Service that periodically fetches weather data from OpenWeatherMap
        API and logs it to a JSON file. Demonstrates:
        - Service lifecycle management (Start, Stop, Pause, Continue)
        - External API integration
        - JSON logging optimized for log aggregation tools (Datadog)
#>

# ============================================================================
# SERVICE LIFECYCLE FUNCTIONS
# ============================================================================
# WARNING: Do not rename these functions - they are called by the service wrapper

function Start-MyService {
    <#
    .SYNOPSIS
        Called when the service starts.
    .DESCRIPTION
        Initialize global state variables and any resources needed by the service.
        This runs once when the service transitions from Stopped to Running.
    #>
    $ErrorActionPreference = 'Stop'

    # Service state management variables
    $global:bRunService = $true       # Main loop control
    $global:bServiceRunning = $false  # Indicates main loop is active
    $global:bServicePaused = $false   # Indicates service is paused
}

function Invoke-MyService {
    <#
    .SYNOPSIS
        Main service loop - runs continuously while service is active.
    .DESCRIPTION
        This is where the service does its work. The loop continues until
        Stop-MyService sets bRunService to false.
    #>
    $global:bServiceRunning = $true

    while ($global:bRunService) {
        try {
            # Only process when not paused
            if ($global:bServicePaused -eq $false) {
                # Execute main service logic
                Main
                # Write-Host outputs to Windows Application event log
            }
        }
        catch {
            # Log exceptions to Application event log
            Write-Host $_.Exception.Message
        }

        # Sleep between iterations
        # Longer sleep when paused to reduce CPU usage
        if ($global:bServicePaused -eq $true) {
            Start-Sleep -Seconds 20
        }
        else {
            Start-Sleep -Seconds 60  # Check weather every minute
        }
    }

    $global:bServiceRunning = $false
}

function Stop-MyService {
    <#
    .SYNOPSIS
        Called when the service stops.
    .DESCRIPTION
        Signal the main loop to exit and wait for graceful shutdown.
        Clean up any resources (files, connections, etc.)
    #>
    $global:bRunService = $false

    # Wait for main loop to exit (max 30 seconds)
    $CountDown = 30
    while ($global:bServiceRunning -and $Countdown -gt 0) {
        Start-Sleep -Seconds 1
        $Countdown = $Countdown - 1
    }

    # Cleanup code goes here:
    # - Close file handles
    # - Close database connections
    # - Terminate background jobs
    # - Remove-Module for blocking modules
}

function Pause-MyService {
    <#
    .SYNOPSIS
        Called when the service is paused via Service Control Manager.
    .DESCRIPTION
        Set the pause flag. The main loop will check this and skip processing.
        Note: The thread is NOT suspended - your code must check the flag.
    #>
    $global:bServicePaused = $true
}

function Continue-MyService {
    <#
    .SYNOPSIS
        Called when a paused service is resumed.
    .DESCRIPTION
        Clear the pause flag to resume normal processing.
    #>
    $global:bServicePaused = $false
}

# ============================================================================
# MAIN SERVICE LOGIC
# ============================================================================

function Main {
    <#
    .SYNOPSIS
        Main processing function called on each service loop iteration.
    #>
    try {
        $WeatherMessage = Return-Weather
        Add-LogToJson -LogFilePath C:\Temp\WeatherLog.json -Message $WeatherMessage
    }
    catch {
        # Error output goes to Application event log
        $_
    }
}

# ============================================================================
# WEATHER API INTEGRATION
# ============================================================================

function Return-Weather {
    <#
    .SYNOPSIS
        Fetches current weather data from OpenWeatherMap API.
    .OUTPUTS
        String containing formatted weather information.
    #>

    # API Configuration
    $ApiKey = "f2d671ac92e02bdd267cd98a1b7d98a3"
    $City = "Aarhus"
    $ApiUrl = "http://api.openweathermap.org/data/2.5/weather?q=$City&appid=$ApiKey"

    # Call the API
    $Response = Invoke-RestMethod -Uri $ApiUrl -Method Get

    # Extract and convert data
    $Weather = $Response.weather.description
    $Temp = ($Response.main.temp) - 273.15        # Kelvin to Celsius
    $TempFeels = ($Response.main.feels_like) - 273.15

    # Return formatted string
    return "The weather in $City is $Weather with a temperature of {0:F2} Celsius that feels like {1:F2} Celsius" -f $Temp, $TempFeels
}

# ============================================================================
# JSON LOGGING FUNCTION
# ============================================================================

<#
    .SYNOPSIS
        Write log entry to JSON file (Datadog-optimized format).

    .DESCRIPTION
        Writes log entries in compressed JSON format (one entry per line).
        This format is optimized for Datadog agent log collection and other
        log aggregation platforms.

        Uses StreamWriter for non-blocking file writes to prevent the file
        from being locked during writes.

    .PARAMETER LogFilePath
        Path to the log file (.json, .txt, .log). Created if it doesn't exist.

    .PARAMETER LogLevel
        Severity level. Valid values: INFO, WARNING, ERROR, CRITICAL, DEBUG, OK
        Defaults to INFO.

    .PARAMETER Message
        The log message content.

    .PARAMETER Adds
        Optional hashtable of additional attributes to include in the log entry.
        Example: @{server="SRV01"; environment="Production"}

    .EXAMPLE
        Add-LogToJson -LogFilePath 'C:\Temp\Logfile.json' -Message 'Service started'

    .EXAMPLE
        Add-LogToJson -LogFilePath 'C:\Temp\Logfile.json' -LogLevel 'ERROR' -Message 'API call failed' -Adds @{api="weather"; city="Aarhus"}
#>
function Add-LogToJson {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Path to logfile")]
        [String]$LogFilePath,

        [Parameter(Mandatory = $false, HelpMessage = "Logging Level")]
        [ValidateSet('INFO', 'WARNING', 'ERROR', 'CRITICAL', 'DEBUG', 'OK')]
        [String]$LogLevel = 'INFO',

        [Parameter(Mandatory = $true, HelpMessage = "Message String")]
        [String]$Message,

        [hashtable]$Adds
    )

    begin {
        # Create log file if it doesn't exist
        if (!(Test-Path $LogFilePath)) {
            New-Item -Path $LogFilePath -ItemType File -Force | Out-Null
            Write-Verbose "Logfile created: $LogFilePath"
        }

        # Build timestamp
        $Time = Get-Date -Format "dd-MM-yyyy HH:mm:ss,fff"

        # Create log entry hashtable
        $Body = @{
            timestamp = $Time
            message   = $Message
            level     = $LogLevel
        }

        # Merge additional attributes if provided
        if ($Adds) {
            $Body = $Body + $Adds
        }
    }

    process {
        # Write to file using StreamWriter (non-blocking)
        try {
            $stream = [System.IO.StreamWriter]::new($LogFilePath, $true)
            $stream.WriteLine(($Body | ConvertTo-Json -Compress))
        }
        finally {
            $stream.Close()
        }
    }

    end {
        Write-Verbose "$Time - $LogLevel : $Message"
    }
}

# ============================================================================
# SERVICE ENTRY POINT
# ============================================================================

# These calls are made by the service wrapper when starting
Start-MyService
Invoke-MyService

