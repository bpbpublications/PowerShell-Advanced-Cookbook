# Using Test-Connection to Ping a list of IP addresses
Test-Connection -TargetName @(
    "192.168.22.221",
    "192.168.22.222",
    "192.168.22.223") `
-Count 1 | Select-Object Address,Status