# View the list of TrustedHosts
Get-Item WSMan:\localhost\client\TrustedHosts

# Add all computers to the list of TrustedHosts
Set-Item WSMan:\localhost\client\TrustedHosts -Value *

# Add the Hostnames and IP addresses of specific computers to the list of TrustedHosts
$TrustedHosts = "PS-Host01, PS-Host02, 172.26.125.4, 172.26.125.5"
Set-Item WSMan:\localhost\client\TrustedHosts -Value $TrustedHosts

# Add a computer to an existing list of TrustedHosts
$CurrentValue = (Get-Item WSMan:\localhost\client\TrustedHosts).value
Set-Item WSMan:\localhost\Client\TrustedHosts -value "$CurrentValue, Ps-Host03"