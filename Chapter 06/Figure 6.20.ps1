# Figure 6.20 - View WinRM Configuration
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Displays the complete WinRM service configuration.

# ============================================================================
# GET WINRM CONFIGURATION
# ============================================================================

# winrm is the command-line tool for WS-Management configuration
# This displays the complete WinRM configuration hierarchy
winrm get winrm/config

# Expected Output (abbreviated):
# Config
#     MaxEnvelopeSizekb = 500
#     MaxTimeoutms = 60000
#     MaxBatchItems = 32000
#     Client
#         NetworkDelayms = 5000
#         URLPrefix = wsman
#         AllowUnencrypted = false
#         Auth
#             Basic = true
#             Digest = true
#             Kerberos = true
#             Negotiate = true
#             Certificate = true
#         TrustedHosts = PS-Host01
#     Service
#         RootSDDL = ...
#         MaxConcurrentOperations = 4294967295
#         MaxConcurrentOperationsPerUser = 1500
#         EnumerationTimeoutms = 240000
#         Auth
#             Basic = false
#             Kerberos = true
#             Negotiate = true
#             Certificate = false
#     Winrs
#         AllowRemoteShellAccess = true
#         IdleTimeout = 7200000
#         MaxConcurrentUsers = 2147483647

# Key settings to note:
# - Client.TrustedHosts: Computers trusted for NTLM authentication
# - Service.Auth.Certificate: Whether certificate auth is enabled
# - AllowUnencrypted: Should be false in production

# PowerShell alternative to view specific settings:
# Get-Item WSMan:\localhost\Client\TrustedHosts
# Get-Item WSMan:\localhost\Service\Auth\Certificate
