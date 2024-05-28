Configuration WebSite {
    Import-DscResource -ModuleName "PSDesiredStateConfiguration"
    Import-DscResource -ModuleName "xWebAdministration"

    Node "DSCHOST02" {
        # Install the Web Server feature
        WindowsFeature WebServerFeature {
            Ensure = "Present"
            Name   = "Web-Server"
        }
        # Make sure the \MySite folder exists
        File MySiteFolder {
            DependsOn = "[WindowsFeature]WebServerFeature"
            Ensure          = "Present"
            Type            = "Directory"
            DestinationPath = "C:\inetpub\wwwroot\mysite"
            Force = $true
        }
        # Create a simple index.html file in \MySite
        File NewIndexFile {
            DependsOn = "[File]MySiteFolder"
            Ensure          = "Present"
            DestinationPath = "C:\inetpub\wwwroot\mysite\index.html"
            Contents        = "<h1>This is MySite</h1>"
            Force = $true
        }
        # Stop the default website from running (Ensures that port 80 is not binded to this site)
        xWebsite DefaultWebsite {
            DependsOn = "[WindowsFeature]WebServerFeature"
            Ensure      = "Present"
            Name        = "Default Web Site"
            State       = "Stopped"  # Ensure the default website is stopped
            PhysicalPath = "C:\inetpub\wwwroot"
        }
        # Use the xWebAdministration resource to create a new IIS site (MySite)
        xWebsite MyWebsite {
            DependsOn = "[File]MySiteFolder"
            Ensure = "Present"
            Name = "MySite"
            State = "Started"
            PhysicalPath = "C:\inetpub\wwwroot\MySite"
            BindingInfo = @(
                MSFT_xWebBindingInformation {
                    Protocol = "HTTP"
                    Port     = 80
                    IPAddress = "*"
                }
            )
        }

    }
}

# Compile the configuration
WebSite -OutputPath "C:\DSC\WebSite"

# Create the credentials
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

# Start the configuration
Start-DscConfiguration -Path "C:\DSC\WebSite" -Wait -Force -Credential $Credentials

#Test-DscConfiguration -Path "C:\DSC\WebSite" -Credential $Credentials
# Create the credentials
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

# Create a CimSession 
$Session = New-CimSession -ComputerName "DSCHOST01" -Credential $Credentials

# Get the current configuration of the target node
Get-DscConfiguration -CimSession $Session | `
Select-Object ConfigurationName,ModuleName,ResourceId,Ensure