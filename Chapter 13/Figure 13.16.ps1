# Figure 13.16 - Start DSC Configuration
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: Compiled MOF file in specified path

# ============================================================================
# APPLY DSC CONFIGURATION TO TARGET NODES
# ============================================================================

# This figure shows the process of applying a DSC configuration
# Start-DscConfiguration pushes the configuration to target nodes

# Create credentials for remote connection
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)

# Start the DSC configuration
# -Path: Directory containing the compiled .mof files
# -Wait: Wait for the configuration to complete before returning
# -Force: Overwrite any existing pending configuration
# -Credential: Credentials to use for remote connection
Start-DscConfiguration -Path "C:\DSC\WebSite" -Wait -Force -Credential $Credentials

# Expected Output:
# VERBOSE: Perform operation 'Invoke CimMethod' with following parameters,
#          'methodName' = SendConfigurationApply,
#          'className' = MSFT_DSCLocalConfigurationManager,
#          'namespaceName' = root/Microsoft/Windows/DesiredStateConfiguration.
# VERBOSE: An LCM method call arrived from computer DSCSERVER with user sid
#          S-1-5-21-xxxxxxxxxx.
# VERBOSE: [DSCHOST02]: LCM:  [ Start  Set      ]
# VERBOSE: [DSCHOST02]: LCM:  [ Start  Resource ]  [[WindowsFeature]WebServerFeature]
# VERBOSE: [DSCHOST02]: LCM:  [ End    Resource ]  [[WindowsFeature]WebServerFeature]
# ...
# VERBOSE: [DSCHOST02]: LCM:  [ End    Set      ]
# VERBOSE: Operation 'Invoke CimMethod' complete.
#
# NOTE: The configuration is applied synchronously when -Wait is specified
# Without -Wait, the command returns immediately while configuration runs in background

