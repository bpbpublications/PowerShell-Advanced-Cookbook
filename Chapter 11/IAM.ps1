# Recipe: AWS IAM User, Group, and Policy Management
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates complete IAM lifecycle management operations.

# ============================================================================
# PREREQUISITES
# ============================================================================

# Install the IAM Identity management module for the modularized AWS tools
Install-AWSToolsModule AWS.Tools.IdentityManagement

# ============================================================================
# DISCOVER AVAILABLE CMDLETS
# ============================================================================

# List and view AWS User cmdlets
Get-Command | Where-Object { $_.Name -match "IAMuser" }

# List and view AWS Group cmdlets
Get-Command | Where-Object { $_.Name -match "IAMGroup" }

# List and view AWS Policy cmdlets
Get-Command | Where-Object { $_.Name -match "IAMPolicy" }

# List and view AWS EC2 Instance cmdlets
Get-Command | Where-Object { $_.Name -match "EC2Instance" }

# List and view AWS S3 Bucket cmdlets
Get-Command | Where-Object { $_.Name -match "S3Bucket" }

# ============================================================================
# USER OPERATIONS
# ============================================================================

# List all IAM users in the account
Get-IAMUsers

# List current IAM user (the user whose credentials are being used)
Get-IAMUser

# List a specific IAM user by name
Get-IAMUser -UserName NoConsoleAccess

# Create a new IAM user
New-IAMUser -UserName Test
New-IAMUser -UserName ApiAccess

# Update an IAM user (change username)
Update-IAMUser -UserName ApiAccess -NewUserName AppAccess

# Delete an IAM user
Remove-IAMUser -UserName AppAccess
# Skip confirmation prompt
Remove-IAMUser -UserName AppAccess -Confirm:$false

# ============================================================================
# GROUP OPERATIONS
# ============================================================================

# List all account IAM Groups
Get-IAMGroups

# Get a specific IAM Group
Get-IAMGroup -GroupName AdminUsers

# Create a new IAM group
New-IAMGroup -GroupName ApiUsers

# Add IAM user to IAM Group
Add-IAMUserToGroup -UserName ApiAccess -GroupName ApiUsers

# Remove IAM user from IAM Group
Remove-IAMUserFromGroup -UserName ApiAccess -GroupName ApiUsers
# Override confirmation prompt
Remove-IAMUserFromGroup -UserName ApiAccess -GroupName ApiUsers -Confirm:$false

# Delete an IAM Group
Remove-IAMGroup -GroupName ApiUsers
# Override confirmation prompt
Remove-IAMGroup -GroupName ApiUsers -Confirm:$false

# List an IAM user's group memberships
Get-IAMGroupForUser -UserName ApiAccess

# ============================================================================
# CONSOLE ACCESS SETUP
# ============================================================================

# Create a new user with Console access (AWS web interface)
New-IAMUser -UserName ConsoleAccess

# Enable Console access by setting a password
# PasswordResetRequired forces password change on first login
New-IAMLoginProfile -UserName ConsoleAccess `
    -PasswordResetRequired $true `
    -Password "New@Password"

# ============================================================================
# PROGRAMMATIC ACCESS SETUP
# ============================================================================

# Create a new user for programmatic/API access only
New-IAMUser -UserName NoConsoleAccess

# Create access keys for API authentication
# IMPORTANT: SecretAccessKey is only shown once!
New-IAMAccessKey -UserName NoConsoleAccess

# Try to list all IAM users with a user that has no permissions
# This demonstrates the default deny behavior
Get-IAMUsers -AccessKey AKIA5V67JFUT27ZTTORG `
    -SecretKey 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

# ============================================================================
# POLICY CREATION
# ============================================================================

# Create a new Policy using a Here-String for the policy document
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

New-IAMPolicy -PolicyName "ListUsers" `
    -PolicyDocument $ListUsersPolicy `
    -Description "This grants ListUsers permissions for all resources"

# Create a new policy using a policy document from a JSON file
New-IAMPolicy -PolicyName "ListUsers" `
    -PolicyDocument (Get-Content -Raw ListUserPolicy.json) `
    -Description "This grants ListUsers permissions for all resources"

# View a specific policy by ARN
Get-IAMPolicy -PolicyArn "arn:aws:iam::940529233191:policy/ListUsers"

# ============================================================================
# ARN FORMAT REFERENCE
# ============================================================================

# ARN formats:
# arn:partition:service:region:account-id:resource-id
# arn:partition:service:region:account-id:resource-type/resource-id
# arn:partition:service:region:account-id:resource-type:resource-id

# ============================================================================
# POLICY MANAGEMENT
# ============================================================================

# List all available policies
Get-IAMPolicies

# List and search for policies
Get-IAMPolicies | Where-Object { $_.PolicyName -match "List" } |
    Select-Object PolicyName, Arn

# Create a group and attach a policy
New-IAMGroup -GroupName ListUsers

Register-IAMGroupPolicy -GroupName ListUsers `
    -PolicyArn "arn:aws:iam::940529233191:policy/ListUsers"

# Add user to the group (granting permissions)
Add-IAMUserToGroup -UserName NoConsoleAccess -GroupName ListUsers

# ============================================================================
# VERIFY PERMISSIONS
# ============================================================================

# List all IAM users with the NoConsoleAccess user's credentials
# After adding to ListUsers group, this should succeed
Get-IAMUsers -AccessKey AKIA5V67JFUT27ZTTORG `
    -SecretKey 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 |
    Select-Object UserName, Arn

# ============================================================================
# DEPENDENT PERMISSIONS EXAMPLE
# ============================================================================

# Example policy with multiple related permissions
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "secretsmanager:GetSecretValue",
#                 "secretsmanager:ListSecrets"
#             ],
#             "Resource": "*"
#         }
#     ]
# }

# ============================================================================
# USER INFORMATION QUERIES
# ============================================================================

# List an IAM user's details
Get-IAMUser NoConsoleAccess

# List policies attached to an IAM user
Get-IAMUserPolicyList NoConsoleAccess
