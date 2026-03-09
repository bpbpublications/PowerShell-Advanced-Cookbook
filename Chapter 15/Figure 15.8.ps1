# Figure 15.8 - Windows Service Script Implementation
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell Studio - SAPIEN Technologies)
# Prerequisites: PowerShell Studio installed, Administrator privileges
#
# This demonstrates a complete Windows Service implementation in PowerShell.

<#
    .NOTES
    ===========================================================================
     Created with:  SAPIEN Technologies, Inc., PowerShell Studio 2023 v5.8.235
     Created on:    09-01-2024 19:42
     Created by:    Morten Hansen
    ===========================================================================
    .DESCRIPTION
        PowerShell-based Windows Service that logs weather data.
        Demonstrates the service lifecycle: Start, Run, Pause, Continue, Stop.
#>

# ============================================================================
# SERVICE LIFECYCLE FUNCTIONS
# ============================================================================
# WARNING: Do not rename Start-MyService, Invoke-MyService, Stop-MyService,
#          Pause-MyService, or Continue-MyService functions.
#          These names are required by the service wrapper.

function Start-MyService {
    # Place one-time startup code here
    # This runs when the service starts
    $ErrorActionPreference = 'Stop'

    # Initialize global variables for service state management
    $global:bRunService = $true       # Controls main loop
    $global:bServiceRunning = $false  # Indicates if loop is active
    $global:bServicePaused = $false   # Indicates if service is paused
}

function Invoke-MyService {
    # Main service loop - runs continuously while service is active
    $global:bServiceRunning = $true

    while ($global:bRunService) {
        try {
            # Only process if service is not paused
            if ($global:bServicePaused -eq $false) {
                # Call your main processing function
                Main
                # Write-Host outputs to System Application log
            }
        }
        catch {
            # Log exceptions to application log
            Write-Host $_.Exception.Message
        }

        # Adjust sleep timing based on service state
        if ($global:bServicePaused -eq $true) {
            # Sleep longer when paused to reduce CPU usage
            Start-Sleep -Seconds 20
        }
        else {
            # Normal interval between processing cycles
            Start-Sleep -Seconds 60
        }
    }

    $global:bServiceRunning = $false
}

function Stop-MyService {
    # Signal main loop to exit
    $global:bRunService = $false

    # Wait for main loop to exit gracefully (max 30 seconds)
    $CountDown = 30
    while ($global:bServiceRunning -and $Countdown -gt 0) {
        Start-Sleep -Seconds 1
        $Countdown = $Countdown - 1
    }

    # Place cleanup code here:
    # - Close file handles
    # - Close database connections
    # - Terminate background jobs
    # - Use Remove-Module for blocking modules
}

function Pause-MyService {
    # Service is being paused via Service Control Manager
    $global:bServicePaused = $true

    # NOTE: The PowerShell thread is NOT suspended on pause
    # Your code must check $bServicePaused and skip processing
}

function Continue-MyService {
    # Service is being resumed from paused state
    $global:bServicePaused = $false
}

# ============================================================================
# MAIN PROCESSING FUNCTION
# ============================================================================

function Main {
    try {
        # Get weather data and log it
        $WeatherMessage = Return-Weather
        Add-LogToJson -LogFilePath C:\Temp\WeatherLog.json -Message $WeatherMessage
    }
    catch {
        # Output error (goes to Application log)
        $_
    }
}

# ============================================================================
# WEATHER API FUNCTION
# ============================================================================

function Return-Weather {
    # OpenWeatherMap API configuration
    $ApiKey = "f2d671ac92e02bdd267cd98a1b7d98a3"
    $City = "Aarhus"
    $ApiUrl = "http://api.openweathermap.org/data/2.5/weather?q=$City&appid=$ApiKey"

    # Call the weather API
    $Response = Invoke-RestMethod -Uri $ApiUrl -Method Get

    # Extract weather data
    $Weather = $Response.weather.description
    $Temp = ($Response.main.temp) - 273.15      # Kelvin to Celsius
    $TempFeels = ($Response.main.feels_like) - 273.15

    # Return formatted message
    return "The weather in $City is $Weather with a temperature of {0:F2} Celsius that feels like {1:F2} Celsius" -f $Temp, $TempFeels
}

# ============================================================================
# JSON LOGGING FUNCTION
# ============================================================================

<#
    .SYNOPSIS
        Write log entry to JSON file (optimized for Datadog).

    .DESCRIPTION
        Writes log entries in compressed JSON format, one entry per line.
        Compatible with Datadog agent log collection.

    .PARAMETER LogFilePath
        Path to log file (.json, .txt, .log)

    .PARAMETER LogLevel
        Severity level: INFO, WARNING, ERROR, CRITICAL, DEBUG, OK

    .PARAMETER Message
        Log message content

    .PARAMETER Adds
        Additional attributes as hashtable

    .EXAMPLE
        Add-LogToJson -LogFilePath 'C:\Temp\Log.json' -Message 'Test message'

    .EXAMPLE
        Add-LogToJson -LogFilePath 'C:\Temp\Log.json' -LogLevel 'ERROR' -Message 'Error occurred' -Adds @{server="SRV01"}
#>
function Add-LogToJson {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$LogFilePath,

        [Parameter(Mandatory = $false)]
        [ValidateSet('INFO', 'WARNING', 'ERROR', 'CRITICAL', 'DEBUG', 'OK')]
        [String]$LogLevel = 'INFO',

        [Parameter(Mandatory = $true)]
        [String]$Message,

        [hashtable]$Adds
    )

    begin {
        # Create log file if it doesn't exist
        if (!(Test-Path $LogFilePath)) {
            New-Item -Path $LogFilePath -ItemType File -Force | Out-Null
            Write-Verbose "Logfile created: $LogFilePath"
        }

        # Build log entry
        $Time = Get-Date -Format "dd-MM-yyyy HH:mm:ss,fff"
        $Body = @{
            timestamp = $Time
            message   = $Message
            level     = $LogLevel
        }

        # Add custom attributes if provided
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
}

# ============================================================================
# SERVICE ENTRY POINT
# ============================================================================

# Start the service (called by service wrapper)
Start-MyService
Invoke-MyService

