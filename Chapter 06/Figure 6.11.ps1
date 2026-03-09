# Figure 6.11 - Register Session Configuration
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires Administrator privileges)
# Registers a custom session configuration on the remote host.

# ============================================================================
# REGISTER SESSION CONFIGURATION
# ============================================================================

# Register-PSSessionConfiguration creates a new endpoint configuration
# Session configurations control what users can do in remote sessions
# -Name: Unique identifier for the configuration
# -Path: Path to the .pssc session configuration file
Register-PSSessionConfiguration -Name MyEnvConfig -Path C:\Temp\SessionConfigs\MyEnvConfig.pssc

# Expected Output:
# WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Plugin\MyEnvConfig
#
# Name          : MyEnvConfig
# Filename      : %windir%\system32\pwrshplugin.dll
# ...

# This command:
# 1. Reads the session configuration file (.pssc)
# 2. Creates a new WinRM plugin/endpoint
# 3. Allows clients to connect using -ConfigurationName MyEnvConfig

# Note: Service restart may be required:
# Restart-Service WinRM

# To unregister a configuration:
# Unregister-PSSessionConfiguration -Name MyEnvConfig

# To view all registered configurations:
# Get-PSSessionConfiguration
