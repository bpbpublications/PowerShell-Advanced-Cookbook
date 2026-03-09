# Figure 13.12 - Simple DSC Configuration
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module

# ============================================================================
# DEFINE DSC CONFIGURATION
# ============================================================================

# A DSC configuration defines the desired state of a system
# This configuration creates an environment variable and a registry key
Configuration SimpleDsc {
    # Import the built-in DSC resource module
    Import-DscResource -ModuleName "PSDesiredStateConfiguration"

    # Define resources for the target node
    Node "DSCHOST01" {
        # Create an environment variable
        # The Environment resource manages system environment variables
        Environment CreateEnvironmentVariable {
            Name   = "DSCNODE"           # Variable name
            Value  = "DSCHOST01"         # Variable value
            Ensure = "Present"           # Ensure it exists
            Path   = $true               # Add to PATH variable
        }

        # Create a registry value
        # The Registry resource manages Windows registry keys and values
        Registry CreateRegistryValue {
            Key       = "HKEY_LOCAL_MACHINE\SOFTWARE\DSC"  # Registry path
            ValueName = "DSCNODE"                          # Value name
            ValueData = "DSCHOST01"                        # Value data
            Ensure    = "Present"                          # Ensure it exists
        }
    }
}

# ============================================================================
# COMPILE THE CONFIGURATION
# ============================================================================

# Compile the configuration to generate a MOF file
# The MOF file is placed in the specified output path
SimpleDsc -OutputPath "C:\DSC\DSCConfigs"

# Expected Output:
#     Directory: C:\DSC\DSCConfigs
#
# Mode                LastWriteTime         Length Name
# ----                -------------         ------ ----
# -a----        1/1/2024   10:00 AM           2788 DSCHOST01.mof
#
# NOTE: The compiled MOF file can now be applied using Start-DscConfiguration
# See Figure 13.16 for applying configurations

