# Figure 11.2 - Listing Available Commands in AWS.Tools.S3
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.S3 module installed

# ============================================================================
# INSTALL AND IMPORT MODULES
# ============================================================================

# Install AWS.Tools installer module (Modularized package)
Install-Module AWS.Tools.Installer

# Install module for Simple Storage Service (S3)
Install-AWSToolsModule AWS.Tools.S3

# Install module for Elastic Compute Cloud service (EC2)
Install-AWSToolsModule AWS.Tools.EC2

# Import the modules
Import-Module AWS.Tools.S3
Import-Module AWS.Tools.EC2

# ============================================================================
# LIST S3 COMMANDS
# ============================================================================

# List all commands available in the AWS.Tools.S3 module
# This shows what operations you can perform with S3
Get-Command -Module AWS.Tools.S3

# Expected Output (partial):
# CommandType     Name                    Version    Source
# -----------     ----                    -------    ------
# Cmdlet          Copy-S3Object           4.x.x.x    AWS.Tools.S3
# Cmdlet          Get-S3Bucket            4.x.x.x    AWS.Tools.S3
# Cmdlet          Get-S3Object            4.x.x.x    AWS.Tools.S3
# Cmdlet          New-S3Bucket            4.x.x.x    AWS.Tools.S3
# Cmdlet          Read-S3Object           4.x.x.x    AWS.Tools.S3
# Cmdlet          Remove-S3Bucket         4.x.x.x    AWS.Tools.S3
# Cmdlet          Remove-S3Object         4.x.x.x    AWS.Tools.S3
# Cmdlet          Write-S3Object          4.x.x.x    AWS.Tools.S3
