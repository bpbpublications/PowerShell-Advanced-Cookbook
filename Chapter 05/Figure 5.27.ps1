# Figure 5.27 - Viewing Commands Exported by a Module
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates how to view all commands (functions, cmdlets, aliases)
# that are exported by a specific module.

# ============================================================================
# PREREQUISITES
# ============================================================================

# Navigate to the modules directory and import the module
Set-Location ".\Modules"
Import-Module .\Logging

# ============================================================================
# VIEW MODULE COMMANDS
# ============================================================================

# Get-Command with -Module parameter lists all commands from that module
Get-Command -Module Logging

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# CommandType     Name                                               Version    Source
# -----------     ----                                               -------    ------
# Function        Add-LogToJson                                      1.0.0      Logging

# ============================================================================
# GET-COMMAND OPTIONS
# ============================================================================

# FILTER BY COMMAND TYPE:
# Get-Command -Module Logging -CommandType Function
# Get-Command -Module Logging -CommandType Cmdlet
# Get-Command -Module Logging -CommandType Alias

# FILTER BY NAME PATTERN:
# Get-Command -Module Logging -Name *Log*

# GET DETAILED COMMAND INFO:
# Get-Command Add-LogToJson | Format-List *

# VIEW COMMAND PARAMETERS:
# (Get-Command Add-LogToJson).Parameters
# Get-Command Add-LogToJson -ShowCommandInfo

# ============================================================================
# EXPLORING MODULE COMMANDS
# ============================================================================

# View help for a module command:
# Get-Help Add-LogToJson -Full

# View command syntax:
# Get-Command Add-LogToJson -Syntax

# List parameters with details:
# (Get-Command Add-LogToJson).Parameters.Values |
#     Select-Object Name, ParameterType, IsMandatory

# ============================================================================
# COMPARING MODULES
# ============================================================================

# Count commands per module:
# Get-Module | ForEach-Object {
#     [PSCustomObject]@{
#         Module = $_.Name
#         CommandCount = (Get-Command -Module $_.Name).Count
#     }
# }

