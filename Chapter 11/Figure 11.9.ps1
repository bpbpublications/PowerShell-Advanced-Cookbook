# Figure 11.9 - Creating IAM Users
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.IdentityManagement, iam:CreateUser permission

# ============================================================================
# CREATE NEW IAM USERS
# ============================================================================

# Expects you to be authenticated with a user with proper permissions
# Required permission: iam:CreateUser

# Attempting to create a user that already exists will produce an error
# This demonstrates error handling for duplicate users
New-IAMUser -UserName Test

# Expected Output (if user exists):
# New-IAMUser : An error occurred (EntityAlreadyExists) when calling CreateUser:
# User with name Test already exists.

# This user is not expected to exist - creates successfully
New-IAMUser -UserName ApiAccess

# Expected Output (success):
# Arn              : arn:aws:iam::123456789012:user/ApiAccess
# CreateDate       : 11/02/2023 14:30:00
# PasswordLastUsed :
# Path             : /
# PermissionsBoundary :
# Tags             : {}
# UserId           : AIDAEXAMPLENEWUSER01
# UserName         : ApiAccess
#
# NOTE: New users have no permissions by default
# You must attach policies or add them to groups to grant access
