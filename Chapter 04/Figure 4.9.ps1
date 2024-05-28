$ErrorActionPreference = "Ignore"

Get-Content -Path "NonExistingFile.txt"
Write-Output "Ignores all errors. Script execution continues"