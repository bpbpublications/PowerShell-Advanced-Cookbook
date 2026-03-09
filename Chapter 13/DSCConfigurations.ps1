# Recipe: Simple DSC Configuration with Apply
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates creating and applying a basic DSC configuration
# that creates an environment variable and registry key on a target node.
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module, WinRM configured on target

# ============================================================================
# DEFINE THE DSC CONFIGURATION
# ============================================================================

# Create a DSC configuration that defines the desired state
# This configuration creates two resources on DSCHOST01
Configuration SimpleDsc {
    # Import the built-in DSC resource module
    Import-DscResource -ModuleName "PSDesiredStateConfiguration"

    # Define the target node and its resources
    Node "DSCHOST01" {
        # Environment resource: Creates a system environment variable
        # This adds DSCNODE to the system's PATH with value "DSCHOST01"
        Environment CreateEnvironmentVariable {
            Name   = "DSCNODE"      # Environment variable name
            Value  = "DSCHOST01"    # Value to set
            Ensure = "Present"      # Ensure the variable exists
            Path   = $true          # Add to the PATH variable
        }

        # Registry resource: Creates a registry key and value
        # This creates HKLM:\SOFTWARE\DSC with a DSCNODE value
        Registry CreateRegistryValue {
            Key       = "HKEY_LOCAL_MACHINE\SOFTWARE\DSC"  # Registry path
            ValueName = "DSCNODE"                          # Value name
            ValueData = "DSCHOST01"                        # Value data
            Ensure    = "Present"                          # Ensure it exists
        }
    }
}

# ============================================================================
# COMPILE THE CONFIGURATION TO MOF
# ============================================================================

# Compile the configuration - this generates a .mof file for each node
# The MOF file is placed in the specified output directory
SimpleDsc -OutputPath "C:\DSC\DSCConfigs"

# Expected Output:
#     Directory: C:\DSC\DSCConfigs
#
# Mode                LastWriteTime         Length Name
# ----                -------------         ------ ----
# -a----        1/1/2024   10:00 AM           2788 DSCHOST01.mof

# ============================================================================
# CREATE CREDENTIALS FOR REMOTE CONNECTION
# ============================================================================

# Create credentials for applying configuration to remote node
# NOTE: In production, use Get-Credential or secure credential storage
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)

# ============================================================================
# APPLY THE CONFIGURATION TO TARGET NODE
# ============================================================================

# Push the compiled configuration to the target node
# -Path: Directory containing the compiled .mof files
# -Wait: Wait for configuration to complete before returning
# -Force: Overwrite any pending configuration
# -Credential: Credentials for remote connection
Start-DscConfiguration -Path "C:\DSC\DSCConfigs" -Wait -Force -Credential $Credentials

# Expected Output:
# VERBOSE: Perform operation 'Invoke CimMethod' with following parameters...
# VERBOSE: [DSCHOST01]: LCM:  [ Start  Set      ]
# VERBOSE: [DSCHOST01]: LCM:  [ Start  Resource ]  [[Environment]CreateEnvironmentVariable]
# VERBOSE: [DSCHOST01]: LCM:  [ End    Resource ]  [[Environment]CreateEnvironmentVariable]
# VERBOSE: [DSCHOST01]: LCM:  [ Start  Resource ]  [[Registry]CreateRegistryValue]
# VERBOSE: [DSCHOST01]: LCM:  [ End    Resource ]  [[Registry]CreateRegistryValue]
# VERBOSE: [DSCHOST01]: LCM:  [ End    Set      ]
# VERBOSE: Operation 'Invoke CimMethod' complete.

