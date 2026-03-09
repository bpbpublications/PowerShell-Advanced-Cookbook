# Recipe: Installing and Configuring AWS.Tools for PowerShell
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates module installation and various authentication methods.

# ============================================================================
# INSTALL AWS.TOOLS MODULES
# ============================================================================

# Install AWS.Tools installer module (Modularized package)
# The modularized approach loads only the services you need
Install-Module AWS.Tools.Installer

# Install module for Simple Storage Service (S3)
Install-AWSToolsModule AWS.Tools.S3

# Install module for Elastic Compute Cloud service (EC2)
Install-AWSToolsModule AWS.Tools.EC2

# ============================================================================
# AUTHENTICATION METHOD 1: ENVIRONMENT VARIABLES
# ============================================================================

# Configure credentials using environment variables
# These are read automatically by AWS cmdlets
# NOTE: Replace with your actual credentials
$Env:AWS_ACCESS_KEY_ID = "AKIA5V67JFUTZOF4UQNQ"
$Env:AWS_SECRET_ACCESS_KEY = "tQCwC1zWals61T5fqSnk7R1F+OHNMpLjAgyixYYx"
$Env:AWS_DEFAULT_REGION = "eu-north-1"

# ============================================================================
# AUTHENTICATION METHOD 2: SET-AWSCREDENTIALS CMDLET
# ============================================================================

# Configure credentials using the Set-AWSCredentials cmdlet
# This sets credentials for the current PowerShell session
Set-AWSCredentials `
    -AccessKey "AKIA5V67JFUTZOF4UQNQ" `
    -SecretKey "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"

# ============================================================================
# AUTHENTICATION METHOD 3: PER-COMMAND CREDENTIALS
# ============================================================================

# Specify credentials for a single cmdlet
# Useful for running commands as different users
Get-S3Bucket `
    -AccessKey "AKIA5V67JFUTZOF4UQNQ" `
    -SecretKey "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"

# ============================================================================
# AUTHENTICATION METHOD 4: CREDENTIALS FILE (RECOMMENDED)
# ============================================================================

# Specify credentials using credentials file
# Default location: %USERPROFILE%\.aws\credentials (Windows)
#                   ~/.aws/credentials (Linux/Mac)

# Create the directory/file if it does not exist:
# New-Item -Path "$($env:USERPROFILE)\.aws\credentials" -ItemType file -Force

# Add the following lines to the file (without the # comment markers):
# [default]
# aws_access_key_id = AKIA5V67JFUTZOF4UQNQ
# aws_secret_access_key = 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

# You can use an environment variable to change the path to the credentials file:
# $ENV:AWS_SHARED_CREDENTIALS_FILE = "C:\NewPathTo\credentials"

# ============================================================================
# NOTES
# ============================================================================

# Credential Precedence (highest to lowest):
# 1. Explicit parameters (-AccessKey, -SecretKey) on individual cmdlets
# 2. Environment variables (AWS_ACCESS_KEY_ID, etc.)
# 3. Shared credentials file (~/.aws/credentials)
# 4. IAM role (when running on EC2 or Lambda)
#
# SECURITY BEST PRACTICES:
# - Never commit credentials to source control
# - Use IAM roles when running on AWS infrastructure
# - Rotate access keys regularly
# - Use the principle of least privilege for IAM policies
