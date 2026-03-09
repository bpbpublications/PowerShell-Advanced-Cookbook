# Figure 13.19 - Get DSC Configuration Status
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
# GET DSC CONFIGURATION STATUS
# ============================================================================

# Get-DscConfigurationStatus returns information about the last configuration run
# This is useful for monitoring and troubleshooting DSC operations
Get-DscConfigurationStatus -CimSession $Session

# Expected Output (successful configuration):
# Status                   : Success
# StartDate                : 1/1/2024 10:00:00 AM
# Type                     : Initial
# Mode                     : PUSH
# RebootRequested          : False
# NumberOfResources        : 2
# ResourcesInDesiredState  : {[Environment]CreateEnvironmentVariable,
#                            [Registry]CreateRegistryValue}
# ResourcesNotInDesiredState: {}
# DurationInSeconds        : 5
# Error                    :
# JobID                    : {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
# PSComputerName           : DSCHOST01
#
# Key Properties:
# - Status: Success, Failure, or InProgress
# - Type: Initial (first run), Consistency (periodic check), or Reboot
# - ResourcesInDesiredState: Resources that match desired state
# - ResourcesNotInDesiredState: Resources that need to be corrected
# - Error: Contains error details if Status is Failure

