# Figure 6.12 - Use Custom Session Configuration
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates connecting to a remote host using a custom session configuration.

# ============================================================================
# CREATE SESSION WITH CUSTOM CONFIGURATION
# ============================================================================

# -ConfigurationName specifies which session configuration to use
# Custom configurations can provide specific environment variables,
# restrict commands, or customize the session environment
$Session = New-PSSession -ComputerName "PS-Host01" `
    -Credential (Get-Credential) `
    -Name "Host01" `
    -ConfigurationName MyEnvConfig

# ============================================================================
# VIEW ENVIRONMENT VARIABLES
# ============================================================================

# Invoke a command to view all environment variables in the custom session
# Custom configurations can inject specific environment variables
Invoke-Command -Session $Session -ScriptBlock { Get-ChildItem env: }

# Expected Output (includes custom variables from configuration):
# Name                           Value
# ----                           -----
# CUSTOM_DB_CONNECTION_STRING    Server=sql.example.com;Database=mydb...
# CUSTOM_API_KEY                 your-api-key
# CUSTOM_CONFIG_FILE             C:\Path\To\Your\ConfigFile.conf
# COMPUTERNAME                   PS-HOST01
# ... (standard environment variables)

# Benefits of custom session configurations:
# - Inject secrets/connection strings without hardcoding in scripts
# - Restrict available commands for security
# - Set specific language mode (ConstrainedLanguage, NoLanguage)
# - Define RunAs credentials for elevated operations
