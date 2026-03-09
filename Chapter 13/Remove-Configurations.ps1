# Recipe: Remove DSC Configuration Documents
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates how to remove DSC configuration documents
# from a target node to reset its DSC state.
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module, WinRM configured on target

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
$Session = New-CimSession -ComputerName "DSCHOST01" -Credential $Credentials

# ============================================================================
# VIEW CURRENT CONFIGURATION STATUS (OPTIONAL)
# ============================================================================

# Check the current DSC status before removing configurations
# Get-DscConfigurationStatus -CimSession $Session

# ============================================================================
# REMOVE DSC CONFIGURATION DOCUMENTS
# ============================================================================

# Remove-DscConfigurationDocument removes MOF files from the target node
# This effectively clears the DSC configuration state
#
# -Stage options:
# - Current:  The currently applied configuration (Current.mof)
# - Pending:  Configuration waiting to be applied after reboot (Pending.mof)
# - Previous: The last successfully applied configuration (Previous.mof)
#
# Using all three stages completely resets the node's DSC state

Remove-DscConfigurationDocument -CimSession $Session `
    -Stage Current, Pending, Previous -Force

# Expected Output:
# (No output on success - operation completes silently)

# ============================================================================
# VERIFY CONFIGURATION REMOVAL
# ============================================================================

# After removal, Get-DscConfiguration should return nothing
# Get-DscConfiguration -CimSession $Session
#
# Expected Output:
# (No output - configuration has been removed)
#
# NOTE: Removing configurations does NOT undo changes made by DSC
# Resources (files, registry keys, etc.) remain in their current state
# Only the DSC configuration documents are removed
#
# To fully reset a node:
# 1. Remove configuration documents (this script)
# 2. Manually remove or revert any changes made by DSC
# 3. Apply a new configuration or leave unconfigured

