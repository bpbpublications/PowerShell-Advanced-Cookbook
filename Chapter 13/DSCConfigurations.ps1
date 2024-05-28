# Create the configuration
Configuration SimpleDsc {
    Import-DscResource -ModuleName "PSDesiredStateConfiguration"
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

# Apply config to each target node (Assumes they have the same user, serviceaccount or WinRM is set up with certificate)
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

Start-DscConfiguration -Path "C:\DSC\DSCConfigs" -Wait -Force -Credential $Credentials