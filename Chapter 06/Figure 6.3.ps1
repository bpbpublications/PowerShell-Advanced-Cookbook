# Add remote host to TrustedHosts list
Set-Item WSMan:\localhost\client\TrustedHosts -Value "PS-Host01"