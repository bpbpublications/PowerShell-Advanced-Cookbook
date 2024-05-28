$Log=@{
    Timestamp="01-01-2023 10:00:00"
    Level="INFO"
    Message="This is a log message"
}

$Log | ConvertTo-Json -Compress | Out-File C:\Temp\JsonLog.json

# JSON file output compressed to omit whitespace characters and to fit on one line in the file
Get-Content C:\Temp\JsonLog.json