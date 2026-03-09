# Recipe: Reading JSON Configuration Files
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates reading and parsing JSON configuration files.

# ============================================================================
# READ JSON FILE AND CONVERT TO OBJECT
# ============================================================================

# Get-Content reads the file as text
# ConvertFrom-Json parses it into a PowerShell object
$Config = Get-Content C:\Temp\Config1.json | ConvertFrom-Json

# ============================================================================
# ACCESS CONFIGURATION DATA
# ============================================================================

# Use dot notation to access nested properties
$Config.Config.Database.Instance
$Config.Config.Azure.TenantID
$Config.Config.ServiceAccount[0].UserName

# ============================================================================
# ALTERNATIVE: USING -RAW PARAMETER
# ============================================================================

# -Raw reads entire file as single string (faster for large files)
# $Config = Get-Content C:\Temp\Config1.json -Raw | ConvertFrom-Json

# ============================================================================
# POWERSHELL 7+: -ASHASHTABLE PARAMETER
# ============================================================================

# In PowerShell 7+, you can convert to hashtable instead of PSCustomObject
# $Config = Get-Content C:\Temp\Config1.json | ConvertFrom-Json -AsHashtable
