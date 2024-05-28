function Add-LogToJson {
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
        if (-not(Test-Path $LogFile)) {
            New-Item -Path $LogFile -ItemType File -Force | Out-Null
            Write-Verbose "Logfile created: $LogFile"
        }
        
        $Time = Get-Date -Format "dd-MM-yyyy HH:mm:ss,fff"
        [String]$LogString = "$Time - $Level : $Message"
        
        $Body = @{ }        
        $Body.Add("timestamp", $Time)
        $Body.Add("message", $Message)
        $Body.Add("level", $Level)
        
        if ($Adds) {
            $Body = $Body + $Adds
        }
        
    }
    PROCESS {
        try
        {
            $Stream = [System.IO.StreamWriter]::new($LogFile, $true)
            if ($Compress){
                $Stream.WriteLine("$($Body | ConvertTo-Json -Compress)")
            }
            Else{
                $Stream.WriteLine("$($Body | ConvertTo-Json)")
            }
            Write-Verbose "Successfully written log to file: $LogFile"
        }
        catch{
            Write-Error "Could not create log entry: $_"
        }
        finally {
            try{
                $Stream.close()
            }
            catch{}
        }
    }
    END {
        Write-Verbose $LogString
    }
}
