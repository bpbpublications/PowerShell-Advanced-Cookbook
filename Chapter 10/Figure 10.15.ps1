# Create a local firewall rule on the VM
az vm run-command invoke `
--command-id RunPowerShellScript `
--name "TestVM" `
--resource-group "TestVM"  `
--scripts 'New-NetFirewallRule -Name Allow_WinRM_from_MyIP -DisplayName Allow_WinRM_from_MyIP -Direction Inbound -Action Allow -Protocol TCP -LocalPort 5985 -RemoteAddress 5.186.57.95'
