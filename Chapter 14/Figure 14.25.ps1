# Retrieve a specific firewall rule with selective properties
Get-NetFirewallRule -DisplayName RabbitMQ | `
Select-Object DisplayName,Enabled,Profile,Direction,Action

# Disable firewall rule
Disable-NetFirewallRule -DisplayName RabbitMQ

# Retrieve a specific firewall rule with selective properties
Get-NetFirewallRule -DisplayName RabbitMQ | `
Select-Object DisplayName,Enabled,Profile,Direction,Action

# Enable firewall rule
Enable-NetFirewallRule -DisplayName RabbitMQ
