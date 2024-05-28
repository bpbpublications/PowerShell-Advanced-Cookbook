# Get all IPv4 addresses for the Ethernet interface (Filtered output)
Get-NetIPAddress `
-InterfaceAlias "Ethernet" `
-AddressFamily IPv4 | `
Select-Object IPAddress,PrefixLength