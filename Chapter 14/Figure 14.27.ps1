# Retrieve a specific firewall rule with selective properties
Get-NetFirewallRule -DisplayName RabbitMQ | `
Select-Object DisplayName,Enabled,Profile,Direction,Action

# Remove firewall rule
Remove-NetFirewallRule -DisplayName RabbitMQ

# Retrieve a specific firewall rule with selective properties after removal (Results in an error)
Get-NetFirewallRule -DisplayName RabbitMQ | `
Select-Object DisplayName,Enabled,Profile,Direction,Action
