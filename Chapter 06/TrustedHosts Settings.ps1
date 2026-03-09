# Recipe: TrustedHosts Settings
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires Administrator privileges)
# Comprehensive guide to managing the TrustedHosts list for WinRM remoting.

# ============================================================================
# WHY TRUSTEDHOSTS IS NEEDED
# ============================================================================

# In workgroup environments (non-domain joined computers):
# - Kerberos authentication is not available
# - NTLM authentication is used instead
# - WinRM requires explicit trust configuration for NTLM
# - TrustedHosts list defines which computers to trust

# In domain environments:
# - Kerberos provides mutual authentication
# - TrustedHosts is typically not needed
# - Domain membership establishes trust automatically

# ============================================================================
# VIEW CURRENT TRUSTEDHOSTS
# ============================================================================

# View the current TrustedHosts list
# Empty value means no computers are explicitly trusted
Get-Item WSMan:\localhost\client\TrustedHosts

# Expected Output:
#    WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Client
# Type            Name                           Value
# ----            ----                           -----
# System.String   TrustedHosts

# ============================================================================
# TRUST ALL COMPUTERS (NOT RECOMMENDED)
# ============================================================================

# Using wildcard (*) trusts all computers
# WARNING: This reduces security - only use for testing
Set-Item WSMan:\localhost\client\TrustedHosts -Value *

# Expected Output:
# WinRM Security Configuration prompt (unless using -Force)

# ============================================================================
# TRUST SPECIFIC COMPUTERS
# ============================================================================

# Add specific hostnames and IP addresses
# Multiple values are comma-separated (no spaces after commas in value)
$TrustedHosts = "PS-Host01, PS-Host02, 172.26.125.4, 172.26.125.5"
Set-Item WSMan:\localhost\client\TrustedHosts -Value $TrustedHosts

# Expected Output:
# No output on success (or confirmation prompt)

# ============================================================================
# ADD TO EXISTING TRUSTEDHOSTS (APPEND)
# ============================================================================

# Get current value, then append new computer
# This preserves existing entries
$CurrentValue = (Get-Item WSMan:\localhost\client\TrustedHosts).Value
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "$CurrentValue, Ps-Host03"

# Expected Output:
# No output on success

# ============================================================================
# BEST PRACTICES
# ============================================================================

# 1. Be specific - list only computers you need to connect to
# 2. Use hostnames that match DNS/NetBIOS names exactly
# 3. Consider using IP addresses if DNS is unreliable
# 4. For production, prefer HTTPS-based remoting over TrustedHosts
# 5. Regularly audit and clean up the TrustedHosts list

# To clear TrustedHosts completely:
# Set-Item WSMan:\localhost\client\TrustedHosts -Value "" -Force

# To suppress confirmation prompts:
# Set-Item WSMan:\localhost\client\TrustedHosts -Value "PS-Host01" -Force
