# Figure 13.18 - Get DSC Configuration with Selected Properties
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: DSC configuration applied to target node

# ============================================================================
# CREATE CREDENTIALS FOR REMOTE CONNECTION
# ============================================================================

# Create credentials for connecting to the remote node
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)

# ============================================================================
# CREATE CIM SESSION TO TARGET NODE
# ============================================================================

# Create a CIM session for remote DSC operations
$Session = New-CimSession -ComputerName DSCHOST01 -Credential $Credentials

# ============================================================================
# GET DSC CONFIGURATION WITH SELECTED PROPERTIES
# ============================================================================

# Get the current DSC configuration and select specific properties
# This provides a cleaner, more focused view of the configuration
Get-DscConfiguration -CimSession $Session | `
    Select-Object ConfigurationName, ModuleName, ResourceId, Ensure

# Expected Output:
# ConfigurationName ModuleName                   ResourceId                                Ensure
# ----------------- ----------                   ----------                                ------
# SimpleDsc         PSDesiredStateConfiguration  [Environment]CreateEnvironmentVariable    Present
# SimpleDsc         PSDesiredStateConfiguration  [Registry]CreateRegistryValue             Present
#
# For a WebSite configuration, output might include:
# WebSite           PSDesiredStateConfiguration  [WindowsFeature]WebServerFeature          Present
# WebSite           PSDesiredStateConfiguration  [File]MySiteFolder                        Present
# WebSite           PSDesiredStateConfiguration  [File]NewIndexFile                        Present
# WebSite           xWebAdministration           [xWebsite]DefaultWebsite                  Present
# WebSite           xWebAdministration           [xWebsite]MyWebsite                       Present
#
# NOTE: Select-Object helps filter the output to show only relevant properties
# This is useful when you need a quick overview of applied resources

