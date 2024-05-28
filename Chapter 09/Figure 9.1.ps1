# Using Get-CimInstance to get Current OS
(Get-CimInstance -ClassName Win32_OperatingSystem).Caption

# Importing on Server 2016 or below build 1809 resulting in WinPSCompatSession 
# using the ActiveDirectory module with PowerShell 7

Import-Module ActiveDirectory