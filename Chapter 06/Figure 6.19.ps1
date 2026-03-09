# Figure 6.19 - Extract API Key from Credential Manager
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates using Credential Manager to securely store and retrieve API keys.

# ============================================================================
# RETRIEVE API KEY FROM CREDENTIAL MANAGER
# ============================================================================

# Credential Manager can store any sensitive string, not just passwords
# API keys, connection strings, and tokens can be stored as "passwords"
$Credential = Get-StoredCredential -Target ApiKey

# Extract the plain text password (API key) using NetworkCredential
# The empty string "" is passed for the username parameter
$ApiKey = [System.Net.NetworkCredential]::new("", $Credential.Password).Password
$ApiKey

# Expected Output:
# sk-abc123xyz456...  (your API key value)

# ============================================================================
# USE CASE EXAMPLE
# ============================================================================

# This pattern is ideal for securely storing API keys for scripts:
#
# 1. Store the API key once (interactive):
#    New-StoredCredential -Target "OpenAI-API" -UserName "api" `
#        -Password "sk-..." -Type Generic
#
# 2. Use in scripts (automated):
#    $ApiKey = [System.Net.NetworkCredential]::new("",
#        (Get-StoredCredential -Target "OpenAI-API").Password).Password
#
#    Invoke-RestMethod -Uri "https://api.openai.com/v1/..." `
#        -Headers @{ "Authorization" = "Bearer $ApiKey" }

# Benefits:
# - API key never appears in script source code
# - Credential Manager provides OS-level encryption
# - Same credential can be used across multiple scripts
