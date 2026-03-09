# Figure 13.15 - Get Current DSC Configuration
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
# GET CURRENT DSC CONFIGURATION
# ============================================================================

# Get-DscConfiguration retrieves the current state of all DSC resources
# on the target node that were applied by the last configuration
Get-DscConfiguration -CimSession $Session

# Expected Output:
# ConfigurationName    : SimpleDsc
# DependsOn            :
# ModuleName           : PSDesiredStateConfiguration
# ModuleVersion        : 1.1
# PsDscRunAsCredential :
# ResourceId           : [Environment]CreateEnvironmentVariable
# SourceInfo           :
# Ensure               : Present
# Name                 : DSCNODE
# Path                 : True
# Value                : DSCHOST01
# PSComputerName       : DSCHOST01
#
# ConfigurationName    : SimpleDsc
# DependsOn            :
# ModuleName           : PSDesiredStateConfiguration
# ModuleVersion        : 1.1
# PsDscRunAsCredential :
# ResourceId           : [Registry]CreateRegistryValue
# SourceInfo           :
# Ensure               : Present
# Key                  : HKEY_LOCAL_MACHINE\SOFTWARE\DSC
# ValueData            : {DSCHOST01}
# ValueName            : DSCNODE
# ValueType            :
# PSComputerName       : DSCHOST01

