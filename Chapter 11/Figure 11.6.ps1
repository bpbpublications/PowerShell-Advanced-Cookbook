# Figure 11.6 - List All IAM Users
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.IdentityManagement, valid AWS credentials

# ============================================================================
# LIST ALL IAM USERS
# ============================================================================

# Expects you to be authenticated with a user with proper permissions
# Required permission: iam:ListUsers

Get-IAMUsers

# Expected Output:
# Arn              : arn:aws:iam::123456789012:user/Admin
# CreateDate       : 01/15/2023 10:30:00
# PasswordLastUsed : 11/01/2023 08:45:00
# Path             : /
# PermissionsBoundary :
# Tags             : {}
# UserId           : AIDAEXAMPLE123456789
# UserName         : Admin
#
# NOTE: The Get-IAMUsers cmdlet (plural) lists all users in the account
# Use Get-IAMUser (singular) to get details about a specific user
