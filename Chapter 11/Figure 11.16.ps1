# Figure 11.16 - Get Current User Context (RM User)
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.IdentityManagement, credentials configured

# ============================================================================
# VERIFY CURRENT USER CONTEXT
# ============================================================================

# This should be in the context of the newly created RM user
# After running Set-AWSCredentials with the RM user's keys

Get-IAMUser

# Expected Output:
# Arn              : arn:aws:iam::123456789012:user/RM
# CreateDate       : 11/02/2023 15:00:00
# PasswordLastUsed :
# Path             : /
# PermissionsBoundary :
# Tags             : {}
# UserId           : AIDAEXAMPLERMUSER001
# UserName         : RM
#
# NOTE: Running Get-IAMUser without parameters shows the current user
# This confirms you're operating with the correct credentials
