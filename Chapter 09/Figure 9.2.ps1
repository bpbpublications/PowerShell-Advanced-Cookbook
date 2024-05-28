# Using Get-CimInstance to get Current OS
(Get-CimInstance -ClassName Win32_OperatingSystem).Caption

# Importing on Server 2022 works as intended when
# using the ActiveDirectory module with PowerShell 7

Import-Module ActiveDirectory