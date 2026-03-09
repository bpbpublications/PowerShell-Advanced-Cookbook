# Figure 14.28 - Windows Firewall with Advanced Security GUI
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows
# Prerequisites: GUI access

# ============================================================================
# WINDOWS FIREWALL WITH ADVANCED SECURITY
# ============================================================================

# This figure shows an image of the Windows Firewall with Advanced Security
# GUI (wf.msc), which provides a graphical interface for firewall management.
#
# To open the Windows Firewall with Advanced Security:
# - Run: wf.msc
# - Or: Control Panel > Windows Defender Firewall > Advanced settings
#
# The GUI provides:
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ Windows Firewall with Advanced Security                                  │
# ├─────────────────────────────────────────────────────────────────────────┤
# │ ├── Inbound Rules                                                        │
# │ │   └── Rules for incoming connections                                  │
# │ ├── Outbound Rules                                                       │
# │ │   └── Rules for outgoing connections                                  │
# │ ├── Connection Security Rules                                            │
# │ │   └── IPsec authentication rules                                      │
# │ └── Monitoring                                                           │
# │     └── View active firewall status                                     │
# └─────────────────────────────────────────────────────────────────────────┘
#
# PowerShell provides the same functionality programmatically:
# - Get-NetFirewallRule: View rules
# - New-NetFirewallRule: Create rules
# - Set-NetFirewallRule: Modify rules
# - Enable/Disable-NetFirewallRule: Toggle rules
# - Remove-NetFirewallRule: Delete rules

