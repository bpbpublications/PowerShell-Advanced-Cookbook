# Figure 6.21 - List WinRM Listeners
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Displays all configured WinRM listeners.

# ============================================================================
# VIEW WINRM LISTENERS
# ============================================================================

# WSMan:\localhost\Listener contains all WinRM listener configurations
# Listeners define how WinRM accepts incoming connections
Get-ChildItem WSMan:\localhost\Listener\

# Expected Output:
# Name                      Type
# ----                      ----
# Listener_1084132640       Container
# Listener_1124534567       Container

# To see details of a specific listener, navigate into it:
# Get-ChildItem WSMan:\localhost\Listener\Listener_1084132640

# Expected detailed output:
# Name                      Value
# ----                      -----
# Address                   *
# Transport                 HTTP
# Port                      5985
# Hostname
# Enabled                   true
# URLPrefix                 wsman
# CertificateThumbprint

# Common listener types:
# - HTTP (port 5985): Default, unencrypted but authenticated
# - HTTPS (port 5986): Encrypted with SSL certificate

# Note: For production, HTTPS listeners are recommended
# HTTPS requires a certificate with matching hostname
