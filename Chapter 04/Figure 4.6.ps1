$ErrorActionPreference = "Stop"

Get-Content -Path "NonExistingFile.txt"
Write-Output "Outputs error. Script execution does not continue"