# Recipe: Create Session Configuration File
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires Administrator privileges)
# Demonstrates creating and deploying custom PowerShell session configurations.

# ============================================================================
# WHAT ARE SESSION CONFIGURATIONS?
# ============================================================================

# Session configurations define:
# - What commands are available in the session
# - What environment variables are preset
# - What language mode is used (Full, Constrained, NoLanguage)
# - What modules are automatically imported
# - Who can connect and what they can do

# Use cases:
# - Inject secrets/connection strings securely
# - Create restricted endpoints for operators
# - Standardize environment across remote sessions

# ============================================================================
# STEP 1: CREATE SESSION CONFIGURATION FILE
# ============================================================================

# Define the path for the configuration file
$ConfigFile = "C:\Temp\SessionConfigs\MyEnvConfig.pssc"

# Create the directory if it doesn't exist
New-Item -Path "C:\Temp\SessionConfigs" -ItemType Directory -Force | Out-Null

# Create a new session configuration file
# -SessionType Default: Full PowerShell capabilities
New-PSSessionConfigurationFile -SessionType Default -Path $ConfigFile

# ============================================================================
# STEP 2: EDIT THE CONFIGURATION FILE
# ============================================================================

# Open the .pssc file and add environment variables within the hashtable
# Add the following content to define custom environment variables:

# EnvironmentVariables = @{
#     "CUSTOM_DB_CONNECTION_STRING" = "Server=sql.example.com;Database=mydb;User=sqluser;Password=secretpassword"
#     "CUSTOM_API_KEY" = "your-api-key"
#     "CUSTOM_CONFIG_FILE" = "C:\Path\To\Your\ConfigFile.conf"
# }

# Other useful settings in the .pssc file:
# - LanguageMode = 'ConstrainedLanguage'  # Restricts scripts
# - VisibleCmdlets = @('Get-*')           # Only allow Get cmdlets
# - VisibleFunctions = @('Get-*')         # Restrict functions
# - ModulesToImport = @('ActiveDirectory') # Auto-import modules

# ============================================================================
# STEP 3: COPY CONFIGURATION TO REMOTE HOST
# ============================================================================

# Create an admin session to the remote host
$Session = New-PSSession -ComputerName "PS-HOST01" `
    -Credential (Get-Credential) `
    -Name "Host01"

# Copy the configuration file to the remote host
# Note: Target directory must exist on the remote host
Copy-Item C:\Temp\SessionConfigs\MyEnvConfig.pssc `
    -Destination C:\Temp\SessionConfigs\MyEnvConfig.pssc `
    -ToSession $Session `
    -Force

# ============================================================================
# STEP 4: REGISTER CONFIGURATION ON REMOTE HOST
# ============================================================================

# Enter the session to run commands directly on remote host
Enter-PSSession $Session

# While connected to remote host, register the configuration
Register-PSSessionConfiguration -Name MyEnvConfig `
    -Path C:\Temp\SessionConfigs\MyEnvConfig.pssc

# Exit the interactive session
Exit-PSSession

# Remove the admin session
Remove-PSSession $Session

# ============================================================================
# STEP 5: USE THE CUSTOM CONFIGURATION
# ============================================================================

# Create a new session using the custom configuration
$Session = New-PSSession -ComputerName "PS-HOST01" `
    -Credential (Get-Credential) `
    -Name "Host01-Env" `
    -ConfigurationName MyEnvConfig

# Verify environment variables are available
Invoke-Command -Session $Session -ScriptBlock { Get-ChildItem env: }

# Expected output includes:
# CUSTOM_DB_CONNECTION_STRING  Server=sql.example.com...
# CUSTOM_API_KEY               your-api-key
# CUSTOM_CONFIG_FILE           C:\Path\To\Your\ConfigFile.conf

# ============================================================================
# CLEANUP AND MANAGEMENT
# ============================================================================

# To unregister a configuration (on remote host):
# Unregister-PSSessionConfiguration -Name MyEnvConfig -Force

# To view all configurations:
# Get-PSSessionConfiguration

# To test configuration file syntax:
# Test-PSSessionConfigurationFile -Path $ConfigFile
