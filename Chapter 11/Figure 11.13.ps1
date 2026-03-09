# Figure 11.13 - Creating an IAM Policy
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.IdentityManagement, iam:CreatePolicy permission

# ============================================================================
# CREATE CUSTOM IAM POLICY
# ============================================================================

# This should be executed with a user that has permissions to create policies
# Required permission: iam:CreatePolicy

# Create a new Policy defining the policy document in a Here-String
# This policy grants permission to list IAM users
$ListUsersPolicy = @"
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "iam:ListUsers",
            "Resource": "*"
        }
    ]
}
"@

# Create the policy in IAM
New-IAMPolicy -PolicyName "ListUsers" `
    -PolicyDocument $ListUsersPolicy `
    -Description "This grants ListUsers permissions for all resources"

# Expected Output:
# Arn                       : arn:aws:iam::123456789012:policy/ListUsers
# AttachmentCount           : 0
# CreateDate                : 11/02/2023 14:45:00
# DefaultVersionId          : v1
# Description               : This grants ListUsers permissions for all resources
# IsAttachable              : True
# Path                      : /
# PermissionsBoundaryUsageCount : 0
# PolicyId                  : ANPAEXAMPLEPOLICYID01
# PolicyName                : ListUsers
# Tags                      : {}
# UpdateDate                : 11/02/2023 14:45:00
#
# NOTE: IAM policies use JSON format following AWS IAM policy syntax
# Version "2012-10-17" is the current policy language version
