# Figure 5.36 - Finding Modules in PowerShell Gallery
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates searching for modules in the public PowerShell Gallery,
# the default repository for PowerShell modules.

# ============================================================================
# FIND MODULE IN PSGALLERY
# ============================================================================

# Find-Module searches PSGallery by default (if no -Repository specified)
Find-Module Logging

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Version    Name      Repository   Description
# -------    ----      ----------   -----------
# 3.4.0      Logging   PSGallery    Easy and powerful logging to console, file...

# ============================================================================
# POWERSHELL GALLERY
# ============================================================================

# The PowerShell Gallery (PSGallery) is:
# - Official Microsoft module repository
# - Contains thousands of community-contributed modules
# - Free to use and publish to
# - URL: https://www.powershellgallery.com

# ============================================================================
# POPULAR MODULES
# ============================================================================

# Find popular logging modules:
# Find-Module -Tag "Logging" | Sort-Object -Property DownloadCount -Descending | Select-Object -First 10

# Find Azure modules:
# Find-Module -Name "Az.*" | Select-Object Name, Version, Description

# Find Pester (testing framework):
# Find-Module -Name Pester

# Find modules by author:
# Find-Module -Filter "Microsoft"

# ============================================================================
# EVALUATING MODULES
# ============================================================================

# Before installing a module, consider:
#
# 1. DOWNLOADS: High download count suggests popularity
#    Find-Module Pester | Select-Object DownloadCount
#
# 2. LAST UPDATE: Recent updates indicate active maintenance
#    Find-Module Pester | Select-Object PublishedDate
#
# 3. PROJECT URI: Check for documentation and source code
#    Find-Module Pester | Select-Object ProjectUri
#
# 4. DEPENDENCIES: Understand what else will be installed
#    Find-Module Pester | Select-Object -ExpandProperty Dependencies

# ============================================================================
# INSTALLING FROM PSGALLERY
# ============================================================================

# Install directly from PSGallery:
# Install-Module -Name Pester -Scope CurrentUser

# Install trusted (no prompts):
# Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
# Install-Module -Name Pester

