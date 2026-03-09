# Figure 13.21 - DSC Configuration with Missing Module
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: Compiled MOF file requiring external DSC resource module

# ============================================================================
# DEMONSTRATE MISSING MODULE ERROR
# ============================================================================

# This figure shows what happens when applying a DSC configuration
# that requires a module not installed on the target node

# Create credentials for remote connection
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)

# Attempt to apply a configuration that uses xWebAdministration module
# If the module is not installed on the target, the configuration will fail
Start-DscConfiguration -Path "C:\DSC\WebSite" -Wait -Force -Credential $Credentials

# Expected Error Output (when module is missing):
# VERBOSE: [DSCHOST02]: LCM:  [ Start  Set      ]
# VERBOSE: [DSCHOST02]: LCM:  [ Start  Resource ]  [[WindowsFeature]WebServerFeature]
# VERBOSE: [DSCHOST02]: LCM:  [ End    Resource ]  [[WindowsFeature]WebServerFeature]
# VERBOSE: [DSCHOST02]: LCM:  [ Start  Resource ]  [[xWebsite]DefaultWebsite]
# PowerShell DSC resource MSFT_xWebsite  module xWebAdministration version
# does not exist at the path C:\Program Files\WindowsPowerShell\Modules
# The SendConfigurationApply function did not succeed.
#
# To resolve this error:
# 1. Install the required module on the target node:
#    Install-Module -Name xWebAdministration -Force
#
# 2. Or use DSC resource module auto-download (Pull mode with a Pull Server)
#
# 3. Or manually copy the module to the target's PowerShell modules path:
#    C:\Program Files\WindowsPowerShell\Modules\xWebAdministration

