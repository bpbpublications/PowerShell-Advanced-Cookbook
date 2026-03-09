# Figure 11.7 - List IAM Users with Selected Properties
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.IdentityManagement, valid AWS credentials

# ============================================================================
# LIST IAM USERS WITH SPECIFIC PROPERTIES
# ============================================================================

# Expects you to be authenticated with a user with proper permissions
# Required permission: iam:ListUsers

# Select only UserName and UserId for a cleaner output
Get-IAMUsers | Select-Object UserName, UserId

# Expected Output:
# UserName          UserId
# --------          ------
# Admin             AIDAEXAMPLE123456789
# Developer         AIDAEXAMPLE987654321
# ServiceAccount    AIDAEXAMPLESVCACCT01
#
# NOTE: Using Select-Object helps focus on relevant properties
# The UserId is a unique identifier that never changes, even if username changes
