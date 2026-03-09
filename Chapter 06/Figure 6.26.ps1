# Figure 6.26 - Certificate-Based Session in Script
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates using certificate-based sessions within automated scripts.

# ============================================================================
# USING SSL SESSIONS IN SCRIPTS
# ============================================================================

# Once certificate-based authentication is configured,
# scripts can connect without credential prompts

# Reference content of RemoteScript.ps1:
### RemoteScript.ps1 Script content ###
# $Session = New-PSSession -ComputerName "PS-HOST01" -UseSSL
# Invoke-Command -Session $Session -ScriptBlock { "I am $($Env:COMPUTERNAME)" }
# Remove-PSSession $Session

# View the script content
Get-Content .\RemoteScript.ps1

# Execute the script
.\RemoteScript.ps1

# Expected Output:
# I am PS-HOST01

# ============================================================================
# BENEFITS OF CERTIFICATE-BASED AUTOMATION
# ============================================================================

# Certificate-based authentication enables:
# 1. Fully automated scripts without password prompts
# 2. Scheduled tasks that run unattended
# 3. CI/CD pipelines with secure remote execution
# 4. Service accounts without stored passwords

# Example scheduled task usage:
# - Create scheduled task running as SYSTEM
# - Machine certificate authenticates automatically
# - No need to store or manage passwords

# Best practices:
# - Use certificates with appropriate validity periods
# - Implement certificate renewal before expiration
# - Monitor certificate expiration dates
# - Keep private keys secure (not exportable when possible)
