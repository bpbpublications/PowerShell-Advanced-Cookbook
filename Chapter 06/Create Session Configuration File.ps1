# Locally create a new session configuration file
$ConfigFile = C:\Temp\SessionConfigs\MyEnvConfig.pssc
New-PSSessionConfigurationFile -SessionType Default -Path $ConfigFile

# Add the below content within the scriptblock within the configuration file

# EnvironmentVariables = @{
#     "CUSTOM_DB_CONNECTION_STRING" = "Server=sql.example.com;Database=mydb;User=sqluser;Password=secretpassword"
#     "CUSTOM_API_KEY" = "your-api-key"
#     "CUSTOM_CONFIG_FILE" = "C:\Path\To\Your\ConfigFile.conf"
# }

# As an Administrator, create a new session to the remote host
$Session = New-PSSession -ComputerName "PS-HOST01" `
-Credential (Get-Credential) `
-Name "Host01"

# Copy the configuration file from the local client to the remote host
# Note: Make sure the folder exists on the remote host
Copy-Item C:\Temp\SessionConfigs\MyEnvConfig.pssc `
-Destination C:\Temp\SessionConfigs\MyEnvConfig.pssc `
-ToSession $Session `
-Force

# Enter the session and connect directly to the remote host.
Enter-PSSession $Session

# Directly logged into the remote host, register the configuration
Register-PSSessionConfiguration -Name MyEnvConfig `
-Path C:\Temp\SessionConfigs\MyEnvConfig.pssc

# Exit entered session on remote host
Exit-PSSession

# Remove the current session
Remove-PSSession $Session

# Create a new session using the MyEnvConfig session configuration
$Session = New-PSSession -ComputerName "PS-HOST01" `
-Credential (Get-Credential) `
-Name "Host01-Env" `
-ConfigurationName MyEnvConfig

# Get all environment variables on the remote host
Invoke-Command -Session $Session -ScriptBlock {dir env:}