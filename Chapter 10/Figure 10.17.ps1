# Add the VM IP address to the clients TrustedHost list
set-item wsman:\localhost\Client\TrustedHosts -value 20.224.74.16

# Create a new WinRM remote session to the VM
$Session = New-PSSession -ComputerName 20.224.74.16 -Credential (Get-Credential)

# Enter VM using session
Enter-PSSession -Session $Session