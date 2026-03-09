# Figure 11.11 - Creating IAM User with Programmatic Access
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.IdentityManagement, iam:CreateUser, iam:CreateAccessKey

# ============================================================================
# CREATE USER WITH API/PROGRAMMATIC ACCESS
# ============================================================================

# Create a new user for programmatic/API access only (no console)
New-IAMUser -UserName NoConsoleAccess

# Create access keys for API authentication
# IMPORTANT: The SecretAccessKey is only shown ONCE - save it securely!
New-IAMAccessKey -UserName NoConsoleAccess

# Expected Output:
# AccessKeyId     : AKIAEXAMPLE123456789
# CreateDate      : 11/02/2023 14:40:00
# SecretAccessKey : wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
# Status          : Active
# UserName        : NoConsoleAccess
#
# SECURITY NOTE: Store the AccessKeyId and SecretAccessKey securely
# The SecretAccessKey cannot be retrieved again - only regenerated
# This user can access AWS via CLI, SDK, or PowerShell but not the console
