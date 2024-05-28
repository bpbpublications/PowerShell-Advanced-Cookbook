# List DNS for specific interface
Get-DnsClientServerAddress `
-InterfaceAlias ethernet `
-AddressFamily IPv4

# Set new DNS addresses for specific interface
Set-DnsClientServerAddress `
-InterfaceAlias ethernet `
-ServerAddresses "8.8.8.8", "8.8.4.4"
