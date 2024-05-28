$ErrorActionPreference = "Continue"

Get-Content -Path "NonExistingFile.txt"
Write-Output "Outputs error. Script execution continues"


$ErrorActionPreference = "Stop"

Get-Content -Path "NonExistingFile.txt"
Write-Output "Outputs error. Script execution does not continue"


$ErrorActionPreference = "SilentlyContinue"

Get-Content -Path "NonExistingFile.txt"
Write-Output "No error output. Script execution continues"


$ErrorActionPreference = "Inquire"

Get-Content -Path "NonExistingFile.txt"
Write-Output "Prompts user for continuation. Shows error. Further execution depends on user answer"


$ErrorActionPreference = "Ignore"

Get-Content -Path "NonExistingFile.txt"
Write-Output "Ignores all errors. Script execution continues"

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