# Create the configuration
Configuration SimpleDsc {
    Import-DscResource –ModuleName "PSDesiredStateConfiguration"
    Node "DSCHOST01" {
        Environment CreateEnvironmentVariable {
            Name = "DSCNODE"
            Value = "DSCHOST01"
            Ensure = "Present"
            Path = $true
        }

        Registry CreateRegistryValue {
            Key         = "HKEY_LOCAL_MACHINE\SOFTWARE\DSC"
            ValueName   = "DSCNODE"
            ValueData   = "DSCHOST01"
            Ensure      = "Present"
        }
    }
}

# Compile the configuration to C:\DSC\DSCConfigs directory
SimpleDsc -OutputPath "C:\DSC\DSCConfigs" 


# This image shows the output of this configuration compilation