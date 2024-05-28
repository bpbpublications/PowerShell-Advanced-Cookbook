# Prerequisites for this Figure
Set-Location ".\Modules"
Import-Module .\Logging

Add-LogToJson -LogFilePath C:\Temp\TestLog.json -Message "This is a test" -LogLevel INFO -Compress -Verbose