# Checking and modifying the state of the TestService service
Get-Service "TestService"
Get-Service "TestService" | Start-Service
Get-Service "TestService"
Get-Service "TestService" | Stop-Service
Get-Service "TestService"