$ErrorActionPreference = "Stop"
try{
    Get-Content -Path "NonExistingFile.txt" -ErrorAction SilentlyContinue
    Write-Output "Does not get caught. Overrides global behavior"

    Get-Content -Path "NonExistingFile.txt"
    Write-Output "Gets caught due to ErrorActionPreference"
}
catch{
    Write-Output "Caught error. ErrorActionPreference=$ErrorActionPreference"
}