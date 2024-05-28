$ErrorActionPreference = "Continue"

Get-Content -Path "NonExistingFile.txt"
Write-Output "Outputs error. Script execution continues"





