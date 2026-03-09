# Figure 10.15 - Create Local Firewall Rule via Run Command
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates running a command on an Azure VM remotely.

# ============================================================================
# RUN COMMAND ON AZURE VM
# ============================================================================

# Use az vm run-command to execute PowerShell on the VM
# This creates a local firewall rule allowing WinRM from your IP
az vm run-command invoke `
    --command-id RunPowerShellScript `
    --name "TestVM" `
    --resource-group "TestVM" `
    --scripts 'New-NetFirewallRule -Name Allow_WinRM_from_MyIP -DisplayName Allow_WinRM_from_MyIP -Direction Inbound -Action Allow -Protocol TCP -LocalPort 5985 -RemoteAddress 5.186.57.95'

# ============================================================================
# RUN-COMMAND BENEFITS
# ============================================================================

# az vm run-command allows you to:
# - Execute scripts without RDP/SSH access
# - Configure VMs that have no public IP
# - Troubleshoot connectivity issues
# - Automate post-deployment configuration
