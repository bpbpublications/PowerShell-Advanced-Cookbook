# Recipe: IIS Website DSC Configuration
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates a comprehensive DSC configuration that:
# - Installs IIS (Web Server feature)
# - Creates a website directory and content
# - Configures IIS websites using xWebAdministration module
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module, xWebAdministration module

# ============================================================================
# DEFINE THE WEBSITE DSC CONFIGURATION
# ============================================================================

Configuration WebSite {
    # Import required DSC resource modules
    Import-DscResource -ModuleName "PSDesiredStateConfiguration"
    Import-DscResource -ModuleName "xWebAdministration"  # Community module for IIS

    Node "DSCHOST02" {
        # ====================================================================
        # INSTALL IIS WEB SERVER
        # ====================================================================

        # Install the Web Server (IIS) Windows feature
        WindowsFeature WebServerFeature {
            Ensure = "Present"
            Name   = "Web-Server"
        }

        # ====================================================================
        # CREATE WEBSITE DIRECTORY
        # ====================================================================

        # Create the website folder structure
        # DependsOn ensures IIS is installed first
        File MySiteFolder {
            DependsOn       = "[WindowsFeature]WebServerFeature"
            Ensure          = "Present"
            Type            = "Directory"
            DestinationPath = "C:\inetpub\wwwroot\mysite"
            Force           = $true
        }

        # ====================================================================
        # CREATE WEBSITE CONTENT
        # ====================================================================

        # Create a simple index.html file for the website
        File NewIndexFile {
            DependsOn       = "[File]MySiteFolder"
            Ensure          = "Present"
            DestinationPath = "C:\inetpub\wwwroot\mysite\index.html"
            Contents        = "<h1>This is MySite</h1>"
            Force           = $true
        }

        # ====================================================================
        # CONFIGURE IIS WEBSITES
        # ====================================================================

        # Stop the default website to free up port 80
        xWebsite DefaultWebsite {
            DependsOn    = "[WindowsFeature]WebServerFeature"
            Ensure       = "Present"
            Name         = "Default Web Site"
            State        = "Stopped"  # Stop the default site
            PhysicalPath = "C:\inetpub\wwwroot"
        }

        # Create and start the new website
        xWebsite MyWebsite {
            DependsOn    = "[File]MySiteFolder"
            Ensure       = "Present"
            Name         = "MySite"
            State        = "Started"
            PhysicalPath = "C:\inetpub\wwwroot\MySite"
            BindingInfo  = @(
                MSFT_xWebBindingInformation {
                    Protocol  = "HTTP"
                    Port      = 80
                    IPAddress = "*"
                }
            )
        }
    }
}

# ============================================================================
# COMPILE THE CONFIGURATION
# ============================================================================

# Compile the configuration to generate the MOF file
WebSite -OutputPath "C:\DSC\WebSite"

# ============================================================================
# CREATE CREDENTIALS AND APPLY CONFIGURATION
# ============================================================================

# Create credentials for remote connection
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)

# Apply the configuration to the target node
Start-DscConfiguration -Path "C:\DSC\WebSite" -Wait -Force -Credential $Credentials

# ============================================================================
# VERIFY THE CONFIGURATION (OPTIONAL)
# ============================================================================

# Test-DscConfiguration -Path "C:\DSC\WebSite" -Credential $Credentials

# Create a CIM session to verify the applied configuration
$Session = New-CimSession -ComputerName "DSCHOST02" -Credential $Credentials

# Get the current configuration status
Get-DscConfiguration -CimSession $Session | `
    Select-Object ConfigurationName, ModuleName, ResourceId, Ensure

# Expected Output:
# ConfigurationName ModuleName                   ResourceId                         Ensure
# ----------------- ----------                   ----------                         ------
# WebSite           PSDesiredStateConfiguration  [WindowsFeature]WebServerFeature   Present
# WebSite           PSDesiredStateConfiguration  [File]MySiteFolder                 Present
# WebSite           PSDesiredStateConfiguration  [File]NewIndexFile                 Present
# WebSite           xWebAdministration           [xWebsite]DefaultWebsite           Present
# WebSite           xWebAdministration           [xWebsite]MyWebsite                Present

