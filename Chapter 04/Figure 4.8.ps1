$ErrorActionPreference = "Inquire"

Get-Content -Path "NonExistingFile.txt"
Write-Output "Prompts user for continuation. Shows error. Further execution depends on user answer"