# Figure 11.10 - Creating IAM User with Console Access
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.IdentityManagement, iam:CreateUser, iam:CreateLoginProfile

# ============================================================================
# CREATE USER WITH AWS CONSOLE ACCESS
# ============================================================================

# Expects you to be authenticated with a user with proper permissions
# Required permissions: iam:CreateUser, iam:CreateLoginProfile

# Create a new user that will access AWS through the web console
New-IAMUser -UserName ConsoleAccess

# Enable Console access by creating a login profile with a password
# PasswordResetRequired forces the user to change password on first login
New-IAMLoginProfile -UserName ConsoleAccess `
    -PasswordResetRequired $true `
    -Password "New@Password"

# Expected Output:
# CreateDate            PasswordResetRequired UserName
# ----------            --------------------- --------
# 11/02/2023 14:35:00   True                  ConsoleAccess
#
# NOTE: The user can now login to https://console.aws.amazon.com
# They will be prompted to change their password on first login
# Remember to also grant permissions via groups or policies
