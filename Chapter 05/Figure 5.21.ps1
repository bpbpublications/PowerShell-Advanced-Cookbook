# Figure 5.21 - Creating a Module Manifest
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates creating a module manifest (.psd1) file which contains
# metadata about a PowerShell module including author, version, and exports.

# ============================================================================
# PREREQUISITES
# ============================================================================

# Navigate to the module directory first
Set-Location ".\Modules\Logging"

# ============================================================================
# CREATE MODULE MANIFEST
# ============================================================================

# New-ModuleManifest creates a .psd1 file with module metadata
# Key parameters:
# - Path: Where to create the manifest file
# - Author: Module author's name
# - RootModule: The main module file (.psm1)
# - ModuleVersion: Semantic version number
# - FunctionsToExport: Public functions available to users
# - Description: Brief description of the module
New-ModuleManifest -Path Logging.psd1 `
    -Author "Morten E. Hansen" `
    -RootModule Logging.psm1 `
    -ModuleVersion 1.0.0 `
    -FunctionsToExport "Add-LogToJson" `
    -Description "Contains misc. Logging functions"

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Creates Logging.psd1 with content similar to:
#
# @{
#     RootModule = 'Logging.psm1'
#     ModuleVersion = '1.0.0'
#     Author = 'Morten E. Hansen'
#     Description = 'Contains misc. Logging functions'
#     FunctionsToExport = @('Add-LogToJson')
#     ...
# }

# ============================================================================
# MODULE MANIFEST OPTIONS
# ============================================================================

# COMMONLY USED PARAMETERS:
# -CompanyName       : Company or organization name
# -Copyright         : Copyright statement
# -PowerShellVersion : Minimum PowerShell version required
# -RequiredModules   : Modules that must be loaded first
# -RequiredAssemblies: .NET assemblies required
# -NestedModules     : Modules loaded into the root module
# -CmdletsToExport   : Cmdlets to export (for binary modules)
# -VariablesToExport : Variables to export
# -AliasesToExport   : Aliases to export
# -PrivateData       : Custom data including PSData for gallery

# EXAMPLE WITH MORE OPTIONS:
# New-ModuleManifest -Path Logging.psd1 `
#     -RootModule Logging.psm1 `
#     -ModuleVersion "1.0.0" `
#     -Author "Author Name" `
#     -CompanyName "Company Name" `
#     -Copyright "(c) 2024 Company. All rights reserved." `
#     -Description "Module description" `
#     -PowerShellVersion "5.1" `
#     -FunctionsToExport @("Add-LogToJson", "Get-Log") `
#     -AliasesToExport @() `
#     -CmdletsToExport @() `
#     -VariablesToExport @() `
#     -Tags @("Logging", "JSON", "PowerShell") `
#     -ProjectUri "https://github.com/example/logging" `
#     -LicenseUri "https://opensource.org/licenses/MIT"

