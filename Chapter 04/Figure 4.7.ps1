$ErrorActionPreference = "SilentlyContinue"

Get-Content -Path "NonExistingFile.txt"
Write-Output "No error output. Script execution continues"