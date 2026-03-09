# Figure 5.22 - Module Directory Structure
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This shows the expected file and folder structure for a PowerShell module.

# ============================================================================
# MODULE STRUCTURE OVERVIEW
# ============================================================================

# Files and folders are placed in the Modules\Logging directory
#
# Modules\
# └── Logging\
#     ├── Logging.psd1           # Module manifest (metadata)
#     ├── Logging.psm1           # Root module (main script)
#     ├── Public\                # Exported functions
#     │   └── Add-LogToJson.ps1
#     └── Private\               # Internal helper functions
#         └── New-HelperFunction.ps1

# ============================================================================
# FILE PURPOSES
# ============================================================================

# LOGGING.PSD1 (Module Manifest):
# - Contains module metadata (author, version, description)
# - Specifies which functions to export
# - Defines dependencies and requirements
# - Required for publishing to PowerShell Gallery

# LOGGING.PSM1 (Root Module):
# - Main module file that loads when Import-Module is called
# - Typically dot-sources files from Public and Private folders
# - Can contain module-level variables and initialization

# PUBLIC FOLDER:
# - Contains functions that are exported to users
# - One function per file (best practice)
# - Function names use approved PowerShell verbs

# PRIVATE FOLDER:
# - Contains helper functions used internally
# - Not exported to module users
# - Used by public functions for common operations

# ============================================================================
# TYPICAL ROOT MODULE CONTENT (Logging.psm1)
# ============================================================================

# $Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)
# $Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)
#
# foreach ($Import in @($Public + $Private)) {
#     try {
#         . $Import.FullName
#     }
#     catch {
#         Write-Error "Failed to import function $($Import.FullName): $_"
#     }
# }
#
# Export-ModuleMember -Function $Public.BaseName

