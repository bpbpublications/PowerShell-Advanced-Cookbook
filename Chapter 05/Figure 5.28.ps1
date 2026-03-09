# Figure 5.28 - Calling a Public Function from a Module
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates calling a public function that was exported
# from a module. Only functions listed in FunctionsToExport are accessible.

# ============================================================================
# PREREQUISITES
# ============================================================================

# Navigate to the modules directory and import the module
Set-Location ".\Modules"
Import-Module .\Logging

# ============================================================================
# CALL PUBLIC FUNCTION
# ============================================================================

# New-PublicFuncOne is a public function exported by the module
# It can be called directly after importing the module
New-PublicFuncOne

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# (Output depends on what New-PublicFuncOne does)
# Example: "Public function executed successfully"

# ============================================================================
# PUBLIC VS PRIVATE FUNCTIONS
# ============================================================================

# PUBLIC FUNCTIONS (accessible after import):
# - Listed in FunctionsToExport in the manifest
# - Can be called by name after Import-Module
# - Visible in Get-Command -Module <ModuleName>

# PRIVATE FUNCTIONS (not accessible):
# - NOT listed in FunctionsToExport
# - Cannot be called directly after Import-Module
# - Not visible in Get-Command
# - Only usable by other functions within the module

# Attempting to call a private function:
# New-HelperFunction  # ERROR: The term 'New-HelperFunction' is not recognized

# ============================================================================
# VERIFYING EXPORTED FUNCTIONS
# ============================================================================

# List all exported functions:
# (Get-Module Logging).ExportedFunctions

# Check if a function is exported:
# (Get-Module Logging).ExportedFunctions.ContainsKey('Add-LogToJson')

# View module manifest exports:
# (Import-PowerShellDataFile .\Logging\Logging.psd1).FunctionsToExport

