# Retrieving information from firewall after it has been modified

# Retrieve a specific firewall rule with selective properties
Get-NetFirewallRule -DisplayName RabbitMQ | `
Select-Object DisplayName,Enabled,Profile,Direction,Action

# Get firewall ports
Get-NetFirewallRule -DisplayName RabbitMQ | Get-NetFirewallPortFilter

# Get firewall addresses
Get-NetFirewallRule -DisplayName RabbitMQ | Get-NetFirewallAddressFilter