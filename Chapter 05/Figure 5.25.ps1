# Figure 5.25 - Module Structure with Public and Private Functions
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This shows the recommended directory structure for organizing
# public (exported) and private (internal) functions in a module.

# ============================================================================
# MODULE STRUCTURE
# ============================================================================

# Files and folders are placed in the Modules\Logging directory
#
# Modules\
# └── Logging\
#     ├── Logging.psd1           # Module manifest
#     ├── Logging.psm1           # Root module script
#     ├── Public\                # Exported functions (visible to users)
#     │   ├── Add-LogToJson.ps1
#     │   └── New-PublicFuncOne.ps1
#     └── Private\               # Internal functions (not exported)
#         └── New-HelperFunction.ps1

# ============================================================================
# PUBLIC VS PRIVATE FUNCTIONS
# ============================================================================

# PUBLIC FUNCTIONS:
# - Placed in the Public folder
# - Exported via FunctionsToExport in manifest
# - Available to module users after Import-Module
# - Should have comment-based help
# - Use approved PowerShell verbs (Get-, Set-, New-, etc.)

# PRIVATE FUNCTIONS:
# - Placed in the Private folder
# - NOT exported in the manifest
# - Only callable by functions within the module
# - Used for helper/utility operations
# - Don't need extensive help documentation

# ============================================================================
# ROOT MODULE PATTERN (Logging.psm1)
# ============================================================================

# # Get public and private function definition files
# $Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)
# $Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)
#
# # Dot source the files
# foreach ($Import in @($Public + $Private)) {
#     try {
#         . $Import.FullName
#     }
#     catch {
#         Write-Error "Failed to import function $($Import.FullName): $_"
#     }
# }
#
# # Export only the public functions
# Export-ModuleMember -Function $Public.BaseName

# ============================================================================
# BENEFITS OF THIS STRUCTURE
# ============================================================================

# 1. CLEAR SEPARATION: Easy to identify what's public vs internal
# 2. ENCAPSULATION: Private functions can't be called externally
# 3. MAINTAINABILITY: One function per file makes changes easier
# 4. TESTABILITY: Each function file can be tested independently
# 5. SCALABILITY: Easy to add new functions without modifying existing files

