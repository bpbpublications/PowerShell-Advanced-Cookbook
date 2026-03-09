# Figure 11.12 - Testing User Without Permissions
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.IdentityManagement

# ============================================================================
# DEMONSTRATE ACCESS DENIED ERROR
# ============================================================================

# Try to list all IAM users with a user without permissions
# Replace the AccessKey and SecretKey with actual values from your user
Get-IAMUsers -AccessKey AKIA5V67JFUT27ZTTORG `
    -SecretKey wmd0daPbp6dsd0UMtmbClYQXsqF5fP7VPcBRzoIN

# Expected Output (Access Denied):
# Get-IAMUsers : User: arn:aws:iam::123456789012:user/NoConsoleAccess
# is not authorized to perform: iam:ListUsers on resource:
# arn:aws:iam::123456789012:user/
#
# NOTE: The -AccessKey and -SecretKey should be replaced to match that
# of the new NoConsoleAccess user!
#
# New IAM users have NO permissions by default
# You must attach policies to grant access to AWS services
