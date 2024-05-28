Get-Module -ListAvailable | Where {$_.Name -eq "Logging"}
Install-Module Logging -Repository PsRepo
Get-Module -ListAvailable | Where {$_.Name -eq "Logging"}