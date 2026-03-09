# Figure 5.31 - Publishing a Module to a Repository
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates publishing a PowerShell module to a repository,
# making it available for others to install using Install-Module.

# ============================================================================
# PUBLISH MODULE
# ============================================================================

# Publish-Module uploads a module to a PowerShell repository
# -Path: Path to the module folder (must contain a manifest .psd1)
# -Repository: Name of the registered repository to publish to
Publish-Module -Path .\Modules\Logging -Repository PsRepo

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# (No output on success)
# The module is now available in the repository

# Verify by searching:
# Find-Module -Name Logging -Repository PsRepo

# ============================================================================
# PREREQUISITES FOR PUBLISHING
# ============================================================================

# 1. MODULE MANIFEST (.psd1):
#    - Must have valid ModuleVersion
#    - Must have Description
#    - Must have Author
#    - Should have LicenseUri, ProjectUri, Tags

# 2. REPOSITORY ACCESS:
#    - Repository must be registered
#    - You need write access to the repository

# 3. API KEY (for PSGallery):
#    - Required for publishing to PowerShell Gallery
#    - Get from: https://www.powershellgallery.com/account/apikeys

# ============================================================================
# PUBLISHING TO POWERSHELL GALLERY
# ============================================================================

# Get an API key from powershellgallery.com, then:
# Publish-Module -Path .\Modules\Logging `
#     -Repository PSGallery `
#     -NuGetApiKey "your-api-key-here"

# ============================================================================
# COMMON PUBLISHING ERRORS
# ============================================================================

# "The module manifest is missing required metadata":
# - Ensure Description is set in manifest
# - Ensure Author is set
# - Ensure ModuleVersion follows semver (1.0.0)

# "A module with this name and version already exists":
# - Increment the version in your manifest
# - Versions cannot be overwritten

# "The repository could not be found":
# - Register the repository first with Register-PSRepository

# ============================================================================
# VERSIONING BEST PRACTICES
# ============================================================================

# Follow Semantic Versioning (semver):
# - MAJOR.MINOR.PATCH (e.g., 1.2.3)
# - MAJOR: Breaking changes
# - MINOR: New features, backward compatible
# - PATCH: Bug fixes, backward compatible

# Update version in manifest before publishing:
# Update-ModuleManifest -Path .\Logging\Logging.psd1 -ModuleVersion "1.1.0"

