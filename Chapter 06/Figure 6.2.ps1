# Run a single command on remote host
Invoke-Command -ComputerName PS-Host01 -ScriptBlock {IpConfig} -Credential (Get-Credential)