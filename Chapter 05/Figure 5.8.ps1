# Figure 5.8 - PowerShell Drives on Linux
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates Get-PSDrive on Linux.
# PowerShell drives provide unified access to different data stores.
#
# Platform: Cross-platform (output varies by OS)

# ============================================================================
# GET POWERSHELL DRIVES
# ============================================================================

# Get-PSDrive lists all available PowerShell drives
# These include file system drives and built-in provider drives
Get-PSDrive

# ============================================================================
# EXPECTED OUTPUT (Linux)
# ============================================================================

# Name           Used (GB)     Free (GB) Provider      Root
# ----           ---------     --------- --------      ----
# /                  45.32        154.68 FileSystem    /
# Alias                                  Alias
# Env                                    Environment
# Function                               Function
# Temp               45.32        154.68 FileSystem    /tmp
# Variable                               Variable

# ============================================================================
# POWERSHELL DRIVE PROVIDERS
# ============================================================================

# FILESYSTEM PROVIDER:
# - / : Root filesystem on Linux
# - Temp: Temporary directory (/tmp on Linux)
# - On Windows: C:, D:, etc.

# BUILT-IN PROVIDERS (Cross-platform):
# - Alias: Command aliases (dir -> Get-ChildItem)
# - Env: Environment variables
# - Function: Loaded functions
# - Variable: PowerShell variables

# WINDOWS-ONLY PROVIDERS:
# - Cert: Certificate store
# - HKLM: Registry HKEY_LOCAL_MACHINE
# - HKCU: Registry HKEY_CURRENT_USER
# - WSMan: WS-Management configuration

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

# Navigate to environment variables:
# Set-Location Env:
# Get-ChildItem

# Access specific environment variable:
# Get-Item Env:PATH
# $env:HOME

# List all functions:
# Get-ChildItem Function:

# List all variables:
# Get-ChildItem Variable:

# Check free space on root:
# (Get-PSDrive /).Free / 1GB

