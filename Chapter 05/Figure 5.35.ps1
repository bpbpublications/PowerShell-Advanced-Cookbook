# Figure 5.35 - Finding Modules in Repositories
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates using Find-Module to search for modules in
# registered repositories before installing them.

# ============================================================================
# FIND MODULE IN SPECIFIC REPOSITORY
# ============================================================================

# Search for a module in a specific repository
Find-Module Logging -Repository PsRepo

# ============================================================================
# FIND MODULE IN ALL REPOSITORIES
# ============================================================================

# Search all registered repositories (including PSGallery)
Find-Module Logging

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Version    Name      Repository   Description
# -------    ----      ----------   -----------
# 1.0.0      Logging   PsRepo       Contains misc. Logging functions
# 3.4.0      Logging   PSGallery    Easy and powerful logging to console...

# Note: Same module name may exist in multiple repositories with different content

# ============================================================================
# FIND-MODULE OPTIONS
# ============================================================================

# SEARCH BY NAME PATTERN (wildcards):
# Find-Module -Name "Log*"

# SEARCH BY TAG:
# Find-Module -Tag "Logging", "JSON"

# SEARCH BY COMMAND NAME:
# Find-Module -Command "Add-Log*"

# INCLUDE PRERELEASE VERSIONS:
# Find-Module -Name Logging -AllowPrerelease

# FIND ALL VERSIONS:
# Find-Module -Name Logging -AllVersions

# LIMIT RESULTS:
# Find-Module -Name "Log*" -MaximumVersion 2.0.0

# ============================================================================
# VIEWING MODULE DETAILS
# ============================================================================

# Get full details about a module:
# Find-Module Logging | Format-List *

# Key properties:
# - Name, Version, Description
# - Author, CompanyName
# - PublishedDate
# - ProjectUri, LicenseUri
# - Dependencies
# - Tags
# - ReleaseNotes

# ============================================================================
# INSTALL AFTER FINDING
# ============================================================================

# Pipeline to install:
# Find-Module Logging -Repository PsRepo | Install-Module

# Check dependencies before installing:
# Find-Module Logging | Select-Object -ExpandProperty Dependencies

