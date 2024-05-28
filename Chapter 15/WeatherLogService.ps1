<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2023 v5.8.235
	 Created on:   	09-01-2024 19:42
	 Created by:   	Morten Hansen
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		Description of the PowerShell service.
#>


# Warning: Do not rename Start-MyService, Invoke-MyService and Stop-MyService functions


function Start-MyService
{
	# Place one time startup code here.
	$ErrorActionPreference = 'Stop'
	
	# Initialize global variables and open connections if needed
	$global:bRunService = $true
	$global:bServiceRunning = $false
	$global:bServicePaused = $false
}

function Invoke-MyService
{
	$global:bServiceRunning = $true
	while($global:bRunService) {
		try 
		{
			if($global:bServicePaused -eq $false) #Only act if service is not paused
			{
				#Place code for your service here
				#e.g. $ProcessList = Get-Process solitaire -ErrorAction SilentlyContinue
				Main
				# Use Write-Host or any other PowerShell output function to write to the System's application log
			}
		}
		catch
		{
			# Log exception in application log
			Write-Host $_.Exception.Message
		}
		# Adjust sleep timing to determine how often your service becomes active
		if($global:bServicePaused -eq $true)
		{
			Start-Sleep -Seconds 20 # if the service is paused we sleep longer between checks
		}
		else
		{
			Start-Sleep –Seconds 60 # a lower number will make your service active more often and use more CPU cycles
		}
	}
	$global:bServiceRunning	= $false
}

function Stop-MyService
{
	$global:bRunService = $false # Signal main loop to exit
	$CountDown = 30 # Maximum wait for loop to exit
	while($global:bServiceRunning -and $Countdown -gt 0)
	{
		Start-Sleep -Seconds 1 # wait for your main loop to exit
		$Countdown = $Countdown - 1
	}
	# Place code to be executed on service stop here
	# Close files and connections, terminate jobs and
	# use remove-module to unload blocking modules
}

function Pause-MyService
{
	# Service is being paused
	# Save state 
	$global:bServicePaused = $true
	# Note that the thread your PowerShell script is running on is not suspended on 'pause'.
	# It is your responsibility in the service loop to pause processing until a 'continue' command is issued.
	# It is recommended to sleep for longer periods between loop iterations when the service is paused.
	# in order to prevent excessive CPU usage by simply waiting and looping.
}

function Continue-MyService
{
	# Service is being continued from a paused state
	# Restore any saved states if needed
	$global:bServicePaused = $false
}

function Main
{
	try
	{
		$WeatherMessage = Return-Weather
		Add-LogToJson -LogFilePath C:\Temp\WeatherLog.json -Message $WeatherMessage
	}
	catch
	{
		$_
	}
}

function Return-Weather
{
	
	$ApiKey = "f2d671ac92e02bdd267cd98a1b7d98a3"
	$City = "Aarhus"
	$ApiUrl = "http://api.openweathermap.org/data/2.5/weather?q=$City&appid=$ApiKey"
	
	$Response = Invoke-RestMethod -Uri $ApiUrl -Method Get
	
	$Weather = $Response.weather.description
	$Temp = ($Response.main.temp) - 273.15 # From Kelvin to Celcius
	$TempFeels = ($Response.main.feels_like) - 273.15 # From Kelvin to Celcius
	
	Return "The weather in $City is $Weather with a temperature of {0:F2} Celcius that feels like {1:F2} Celcius" -f $Temp, $TempFeels
}

<#
	.SYNOPSIS
		Write Log to a file in JSON format compressed in one line for Datadog optimization.
	
	.DESCRIPTION
		Write Log to a file in JSON format compressed in one line for Datadog optimization.
		The file can be read by Datadog agent and attributes are properly added to Datadog logs.
		Date attribute will be added in format: "dd-MM-yyyy HH:mm:ss,fff".
		Using Streamwriter to write to file in order to not block the file wile changing it.
	
	.PARAMETER LogFilePath
		Path to a file (.json, .txt, .log). If the file does not exist, it will be created (If permissions allow it)
	
	.PARAMETER LogLevel
		Error level to set. Valid parameters are: INFO, WARNING, ERROR, CRITICAL, DEBUG and OK.
		Defaults to INFO.
	
	.PARAMETER Message
		Enter any message in STRING format.
	
	.PARAMETER Adds
		Optional parameter that takes a hastable @{} with additional attributes to add to Datadog log.
		An example could be to add name and place: @{name="Morten"; place="AarhusN"}.
		Note some attributes could be overwriting Custom Datadog attributes. Refere to the Datadog documentation for more info.
	
	.EXAMPLE
		PS C:\> New-LogToJson -LogFilePath 'c:\Temp\Logfile.json' -Message 'This is a test message'

	.EXAMPLE
		PS C:\> New-LogToJson -LogFilePath 'c:\Temp\Logfile.json' -LogLevel 'ERROR' -Message 'This is a test ERROR message'	-Adds @{name="Morten"; place="AarhusN"}

#>
function Add-LogToJson
{
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true, HelpMessage = "Path to logfile")]
		[String]$LogFilePath,
		[Parameter(Mandatory = $false, HelpMessage = "Logging Level")]
		[ValidateSet('INFO', 'WARNING', 'ERROR', 'CRITICAL', 'DEBUG', 'OK')]
		[String]$LogLevel = 'INFO',
		[Parameter(Mandatory = $true, HelpMessage = "Message String")]
		[String]$Message,
		[hashtable]$Adds
		
	)
	
	BEGIN
	{
		#Test if logfile exist, else create it
		if (!(Test-Path $LogFilePath))
		{
			New-Item -Path $LogFilePath -ItemType File -Force | Out-Null
			Write-Verbose "Logfile created: $LogFilePath"
		}
		
		#Date/Time info 
		$Time = Get-Date -Format "dd-MM-yyyy HH:mm:ss,fff"
		[String]$LogString = "$Time - $LogLevel : $Message"
		
		$Body = @{ }
		
		$body.Add("timestamp", $Time)
		$body.Add("message", $Message)
		$body.Add("level", $LogLevel)
		#$body.Add("text", $Message)
		
		if ($Adds)
		{
			
			$Body = $Body + $Adds
		}
		
	}
	PROCESS
	{
		#Add content to logfile 
		try
		{
			$stream = [System.IO.StreamWriter]::new($LogFilePath, $true)
			"$($body | ConvertTo-Json -Compress)" | ForEach-Object{ $stream.WriteLine($_) }
		}
		finally
		{
			$stream.close()
		}
		
	}
	END
	{
		Write-Verbose $LogString
	}
	
}

Start-MyService
Invoke-MyService