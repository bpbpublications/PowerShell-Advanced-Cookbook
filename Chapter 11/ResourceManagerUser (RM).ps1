# Recipe: Creating a Resource Manager (RM) User with Multiple Permissions
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates creating an IAM user with permissions for EC2, S3, Secrets Manager,
# and user management through group-based policy attachment.

# ============================================================================
# CREATE IAM USER
# ============================================================================

# Create a new user with permission for EC2, S3, Secrets Manager,
# and for listing and deleting users

# Create the IAM user
$User = New-IAMUser -UserName RM

# Create access key for the user (for programmatic access)
# IMPORTANT: Save these credentials securely - SecretAccessKey shown only once
$RMUserKey = New-IAMAccessKey -UserName $User.UserName

# ============================================================================
# CREATE IAM GROUP
# ============================================================================

# Create the IAM group for Resource Manager users
$Group = New-IAMGroup -GroupName RMGroup

# Add the user to the group
Add-IAMUserToGroup -UserName $User.UserName `
    -GroupName $Group.GroupName

# ============================================================================
# CREATE CUSTOM POLICY
# ============================================================================

# Create a policy that has permissions to manage users
# This includes getting, listing, and deleting users plus related cleanup
$CustomPolicy = @"
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetUser",
                "iam:ListUsers",
                "iam:DeleteUser",
                "iam:ListAccessKeys",
                "iam:DeleteAccessKey",
                "iam:ListUserPolicies",
                "iam:DeleteUserPolicy",
                "iam:ListGroupsForUser",
                "iam:RemoveUserFromGroup"
            ],
            "Resource": "*"
        }
    ]
}
"@

# Create the custom policy in IAM
$NewCustomPolicy = New-IAMPolicy -PolicyName "RMPolicy" `
    -PolicyDocument $CustomPolicy `
    -Description "This grants custom permissions for resource management"

# ============================================================================
# ATTACH POLICIES TO GROUP
# ============================================================================

# Define relevant AWS-managed and custom policies
$Policies = @(
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"           # Full EC2 access
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"            # Full S3 access
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite"       # Secrets Manager
    "$($NewCustomPolicy.Arn)"                                # Custom user management
)

# Attach each policy to the group
foreach ($Policy in $Policies) {
    Register-IAMGroupPolicy -GroupName $Group.GroupName `
        -PolicyArn $Policy
}

# ============================================================================
# SET CREDENTIALS FOR NEW USER
# ============================================================================

# Switch to the new RM user's credentials
Set-AWSCredentials -AccessKey $RMUserKey.AccessKeyId `
    -SecretKey $RMUserKey.SecretAccessKey

# ============================================================================
# EXAMPLE OUTPUT
# ============================================================================

# Expected output from New-IAMAccessKey:
# AccessKeyId     : AKIA5V67JFUTZUD4L5EI
# CreateDate      : 02-11-2023 19:50:50
# SecretAccessKey : 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
# Status          : Active
# UserName        : RM

# Alternative way to set credentials if you have saved them:
# Set-AWSCredentials -AccessKey AKIA5V67JFUTZUD4L5EI `
#     -SecretKey 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

# ============================================================================
# NOTES
# ============================================================================

# The RM user now has permissions to:
# - Create, start, stop, and terminate EC2 instances
# - Create, read, and delete S3 buckets and objects
# - Create and retrieve secrets in Secrets Manager
# - List, get, and delete IAM users (including cleanup operations)
#
# This pattern of group-based permissions is recommended because:
# 1. Policies are attached to groups, not individual users
# 2. New users gain permissions simply by joining the group
# 3. Permission changes affect all group members at once
# 4. It's easier to audit and manage permissions at scale
