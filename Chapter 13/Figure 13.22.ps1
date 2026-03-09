# Figure 13.22 - DSC Configuration Status After Failure
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: DSC configuration that failed to apply

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
# CHECK CONFIGURATION AFTER FAILURE
# ============================================================================

# Get the current DSC configuration
# After a failure, this may show partial or no configuration
Get-DscConfiguration -CimSession $Session

# Expected Output (after failed configuration):
# (May return nothing or partial resources if configuration failed mid-way)

# ============================================================================
# CHECK CONFIGURATION STATUS AFTER FAILURE
# ============================================================================

# Get the DSC configuration status to see failure details
Get-DscConfigurationStatus -CimSession $Session

# Expected Output (failed configuration):
# Status                   : Failure
# StartDate                : 1/1/2024 10:00:00 AM
# Type                     : Initial
# Mode                     : PUSH
# RebootRequested          : False
# NumberOfResources        : 5
# ResourcesInDesiredState  : {[WindowsFeature]WebServerFeature,
#                            [File]MySiteFolder}
# ResourcesNotInDesiredState: {[xWebsite]DefaultWebsite,
#                             [xWebsite]MyWebsite}
# DurationInSeconds        : 3
# Error                    : PowerShell DSC resource MSFT_xWebsite module
#                            xWebAdministration does not exist...
# JobID                    : {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
# PSComputerName           : DSCHOST01
#
# NOTE: The status shows which resources succeeded and which failed
# Use the Error property to diagnose the root cause

