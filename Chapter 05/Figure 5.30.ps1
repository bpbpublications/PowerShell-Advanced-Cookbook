# Figure 5.30 - Viewing Registered PowerShell Repositories
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates how to view the PowerShell repositories configured
# on your system. Repositories are sources for finding and installing modules.

# ============================================================================
# VIEW REGISTERED REPOSITORIES
# ============================================================================

# Get-PSRepository lists all registered module repositories
Get-PSRepository

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Name                      InstallationPolicy   SourceLocation
# ----                      ------------------   --------------
# PSGallery                 Untrusted            https://www.powershellgallery.com/api/v2
# PsRepo                    Trusted              \\server\share\PsRepo

# ============================================================================
# DEFAULT REPOSITORY
# ============================================================================

# PSGALLERY (PowerShell Gallery):
# - Official Microsoft module repository
# - Default repository for Install-Module
# - Contains thousands of community modules
# - URL: https://www.powershellgallery.com

# By default, PSGallery is "Untrusted" for safety
# You'll be prompted before installing modules from untrusted sources

# ============================================================================
# MANAGING REPOSITORIES
# ============================================================================

# SET PSGALLERY AS TRUSTED:
# Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

# REGISTER A NEW REPOSITORY:
# Register-PSRepository -Name "MyRepo" `
#     -SourceLocation "\\server\share\modules" `
#     -InstallationPolicy Trusted

# REGISTER A NUGET FEED:
# Register-PSRepository -Name "MyNuGetFeed" `
#     -SourceLocation "https://mynuget.example.com/api/v2" `
#     -PublishLocation "https://mynuget.example.com/api/v2/package" `
#     -InstallationPolicy Trusted

# REMOVE A REPOSITORY:
# Unregister-PSRepository -Name "MyRepo"

# ============================================================================
# PRIVATE REPOSITORIES
# ============================================================================

# Organizations often create private repositories for:
# - Internal modules not suitable for public gallery
# - Controlled distribution of approved modules
# - Faster downloads (local network vs internet)
# - Air-gapped environments

# Common private repository options:
# - File share (\\server\share)
# - Azure Artifacts
# - ProGet
# - Nexus Repository
# - JFrog Artifactory

