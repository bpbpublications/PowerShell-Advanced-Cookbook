# Figure 11.8 - Get Current IAM User (Context)
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.IdentityManagement, valid AWS credentials

# ============================================================================
# GET CURRENT USER CONTEXT
# ============================================================================

# Expects you to be authenticated with a user with proper permissions
# Required permission: iam:GetUser

# Get-IAMUser without parameters returns the currently authenticated user
# This is useful to verify which credentials are active
Get-IAMUser

# Expected Output:
# Arn              : arn:aws:iam::123456789012:user/YourUsername
# CreateDate       : 01/15/2023 10:30:00
# PasswordLastUsed : 11/01/2023 08:45:00
# Path             : /
# PermissionsBoundary :
# Tags             : {}
# UserId           : AIDAEXAMPLE123456789
# UserName         : YourUsername
#
# NOTE: This confirms which IAM user's credentials are being used
# Very useful for debugging permission issues
