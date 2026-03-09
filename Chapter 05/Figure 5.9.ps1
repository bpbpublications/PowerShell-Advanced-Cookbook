# Figure 5.9 - PowerShell Drives on Windows
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates Get-PSDrive on Windows.
# Windows has additional drive providers like Registry and Certificates.
#
# Platform: Cross-platform (output varies by OS)

# ============================================================================
# GET POWERSHELL DRIVES
# ============================================================================

# Get-PSDrive lists all available PowerShell drives
# Windows includes additional providers not available on Linux/macOS
Get-PSDrive

# ============================================================================
# EXPECTED OUTPUT (Windows)
# ============================================================================

# Name           Used (GB)     Free (GB) Provider      Root
# ----           ---------     --------- --------      ----
# Alias                                  Alias
# C                 234.56        265.44 FileSystem    C:\
# Cert                                   Certificate   \
# D                                      FileSystem    D:\
# Env                                    Environment
# Function                               Function
# HKCU                                   Registry      HKEY_CURRENT_USER
# HKLM                                   Registry      HKEY_LOCAL_MACHINE
# Temp               234.56       265.44 FileSystem    C:\Users\User\AppData\Local\Temp
# Variable                               Variable
# WSMan                                  WSMan

# ============================================================================
# WINDOWS-SPECIFIC PROVIDERS
# ============================================================================

# CERTIFICATE PROVIDER (Cert:):
# - Access Windows certificate stores
# - Navigate: Set-Location Cert:\LocalMachine\My
# - List certs: Get-ChildItem Cert:\CurrentUser\My

# REGISTRY PROVIDER (HKLM:, HKCU:):
# - Access Windows Registry as a filesystem
# - HKLM: HKEY_LOCAL_MACHINE (machine-wide settings)
# - HKCU: HKEY_CURRENT_USER (user-specific settings)

# WSMAN PROVIDER:
# - WS-Management configuration
# - Remote management settings

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

# Browse registry:
# Set-Location HKCU:\Software
# Get-ChildItem

# Get registry value:
# Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName

# List certificates:
# Get-ChildItem Cert:\LocalMachine\My
# Get-ChildItem Cert:\CurrentUser\My

# Check disk space:
# Get-PSDrive C | Select-Object Used, Free

# Create a new mapped drive:
# New-PSDrive -Name Scripts -PSProvider FileSystem -Root "C:\Scripts"

