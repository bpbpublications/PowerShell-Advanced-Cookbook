# Figure 11.1 - Installing AWS.Tools Modules
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: Internet access, PowerShell Gallery access

# ============================================================================
# INSTALL AWS.TOOLS INSTALLER
# ============================================================================

# The AWS.Tools.Installer is a helper module for the modularized AWS SDK
# Unlike the monolithic AWSPowerShell module, AWS.Tools uses separate
# modules for each service, reducing memory footprint
Install-Module AWS.Tools.Installer

# ============================================================================
# INSTALL SERVICE-SPECIFIC MODULES
# ============================================================================

# Install module for Simple Storage Service (S3)
# S3 is AWS's object storage service for files and backups
Install-AWSToolsModule AWS.Tools.S3

# Install module for Elastic Compute Cloud service (EC2)
# EC2 provides virtual machine instances in the cloud
Install-AWSToolsModule AWS.Tools.EC2

# ============================================================================
# IMPORT AND VERIFY MODULES
# ============================================================================

# Import the modules into the current session
Import-Module AWS.Tools.S3
Import-Module AWS.Tools.EC2

# Verify modules are loaded - shows all imported modules
Get-Module

# Expected Output:
# ModuleType Version    Name
# ---------- -------    ----
# Script     4.x.x.x    AWS.Tools.Common
# Script     4.x.x.x    AWS.Tools.EC2
# Script     4.x.x.x    AWS.Tools.S3
