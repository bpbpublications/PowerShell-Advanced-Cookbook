# Figure 13.23 - DSC Configuration Status After Module Installed
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: Missing module installed, configuration re-applied

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
# CHECK CONFIGURATION STATUS AFTER MODULE INSTALLED
# ============================================================================

# After installing the missing module and re-applying the configuration,
# check the status to verify success
Get-DscConfigurationStatus -CimSession $Session

# Expected Output (successful after module installed):
# Status                   : Success
# StartDate                : 1/1/2024 10:30:00 AM
# Type                     : Initial
# Mode                     : PUSH
# RebootRequested          : False
# NumberOfResources        : 5
# ResourcesInDesiredState  : {[WindowsFeature]WebServerFeature,
#                            [File]MySiteFolder,
#                            [File]NewIndexFile,
#                            [xWebsite]DefaultWebsite,
#                            [xWebsite]MyWebsite}
# ResourcesNotInDesiredState: {}
# DurationInSeconds        : 15
# Error                    :
# JobID                    : {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
# PSComputerName           : DSCHOST01
#
# NOTE: All resources are now in the desired state
# The Error field is empty, indicating successful configuration
#
# To fix missing module errors:
# 1. On the target node, run: Install-Module -Name <ModuleName> -Force
# 2. Re-run Start-DscConfiguration or wait for LCM consistency check

