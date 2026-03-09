# Figure 10.17 - Connect to Azure VM with WinRM
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (WinRM client)
# Demonstrates connecting to an Azure VM using PowerShell remoting.

# ============================================================================
# CONFIGURE TRUSTED HOSTS
# ============================================================================

# Add the VM's public IP address to the client's TrustedHosts list
# Required when connecting to non-domain-joined machines
Set-Item WSMan:\localhost\Client\TrustedHosts -Value 20.224.74.16

# ============================================================================
# CREATE REMOTE SESSION
# ============================================================================

# Create a new WinRM remote session to the VM
# Will prompt for credentials (use the VM admin credentials)
$Session = New-PSSession -ComputerName 20.224.74.16 -Credential (Get-Credential)

# Enter the VM's PowerShell session interactively
Enter-PSSession -Session $Session

# ============================================================================
# NOTES
# ============================================================================

# - Requires NSG rule allowing port 5985 from your IP
# - Requires local firewall rule on VM allowing WinRM
# - Use Exit-PSSession to return to local session
# - Use Remove-PSSession to clean up when done
