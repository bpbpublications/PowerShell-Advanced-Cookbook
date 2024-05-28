$Log=@{
    Timestamp="01-01-2023 10:00:00"
    Level="INFO"
    Message="This is a log message"
}

$Log | ConvertTo-Json -Compress | Out-File C:\Temp\JsonLog.json

Get-Content C:\Temp\JsonLog.json