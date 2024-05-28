# "Register" a new service from an executable
New-Service -Name "TestService" `
-DisplayName "TestService" `
-BinaryPathName C:\Temp\TestService\TestService.exe `
-Description "This is a simple test service executable" `
-StartupType Automatic

