# Figure 11.15 - Using Access Keys with Commands
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.IdentityManagement, valid access keys with permissions

# ============================================================================
# LIST USERS WITH SPECIFIC CREDENTIALS
# ============================================================================

# The -AccessKey and -SecretKey should be replaced to match that
# of the new NoConsoleAccess user!

# List all IAM users with the context of the NoConsoleAccess user
# After attaching the ListUsers policy to this user's group, this works
Get-IAMUsers -AccessKey AKIA5V67JFUT27ZTTORG `
    -SecretKey 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 |
    Select-Object UserName, Arn

# Expected Output:
# UserName          Arn
# --------          ---
# Admin             arn:aws:iam::123456789012:user/Admin
# ConsoleAccess     arn:aws:iam::123456789012:user/ConsoleAccess
# NoConsoleAccess   arn:aws:iam::123456789012:user/NoConsoleAccess
#
# NOTE: Using -AccessKey and -SecretKey parameters allows running
# commands in the context of a specific user without changing
# the session's default credentials
