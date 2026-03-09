# Figure 13.13 - View Resources Created by DSC
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: SimpleDsc configuration applied to target node

# ============================================================================
# VERIFY DSC RESOURCES ON TARGET NODE
# ============================================================================

# After applying the SimpleDsc configuration from Figure 13.12,
# verify that the resources were created on the target node

# View computer name to confirm we're on the right node
$env:COMPUTERNAME

# Expected Output:
# DSCHOST01

# ============================================================================
# VIEW ENVIRONMENT VARIABLE CREATED BY DSC
# ============================================================================

# Get the DSCNODE environment variable from machine-level environment
([System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::Machine)).DSCNODE

# Expected Output:
# DSCHOST01

# ============================================================================
# VIEW REGISTRY VALUE CREATED BY DSC
# ============================================================================

# Get the DSCNODE registry value created by DSC
Get-ItemProperty -Path "HKLM:\SOFTWARE\DSC" -Name DSCNODE

# Expected Output:
# DSCNODE      : DSCHOST01
# PSPath       : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\DSC
# PSParentPath : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE
# PSChildName  : DSC
# PSDrive      : HKLM
# PSProvider   : Microsoft.PowerShell.Core\Registry
#
# NOTE: Both resources were created as defined in the DSC configuration
# The LCM will maintain these resources in the desired state

