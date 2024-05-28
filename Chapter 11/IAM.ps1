# Install the IAM Identity management module for the modularized AWS tools module
Install-AWSToolsModule AWS.Tools.IdentityManagement

# List and view AWS User cmdlets
Get-Command | Where-Object {$_.Name -match "IAMuser"}

# List and view AWS Group cmdlets
Get-Command | Where-Object {$_.Name -match "IAMGroup"}

# List and view AWS Policy cmdlets
Get-Command | Where-Object {$_.Name -match "IAMPolicy"}

# List and view AWS EC2 Instance cmdlets
Get-Command | Where-Object {$_.Name -match "EC2Instance"}

# List and view AWS S3 Bucket cmdlets
Get-Command | Where-Object {$_.Name -match "S3Bucket"}

# List all IAM users
Get-IAMUsers

# List current IAM user (Current Context)
Get-IAMUser

# List specific IAM user
Get-IAMUser -UserName NoConsoleAccess

# Create a new IAM user
New-IAMUser -UserName Test
New-IAMUser -UserName ApiAccess

# Update an IAM user (Change username)
Update-IAMUser -UserName ApiAccess -NewUserName AppAccess

# Delete an IAM user
Remove-IAMUser -UserName AppAccess
# Do not prompt for confirmation
Remove-IAMUser -UserName AppAccess -Confirm:$false

####### Groups ########

# List all account IAM Groups
Get-IAMGroups

# Get specific IAM Group
Get-IAMGroup -GroupName AdminUsers

# Create new IAM group
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

# List an IAM user group memberships
Get-IAMGroupForUser -UserName ApiAccess

####### access, policies and permissions #######
# Create a new user and enable Console access and set a password
New-IAMUser -UserName ConsoleAccess

New-IAMLoginProfile -UserName ConsoleAccess `
-PasswordResetRequired $true `
-Password "New@Password"

# Create a new user and enable programmatic/Api access
New-IAMUser -UserName NoConsoleAccess

New-IAMAccessKey -UserName NoConsoleAccess

# Try to list all IAM users with a user without permissions
Get-IAMUsers -AccessKey AKIA5V67JFUT27ZTTORG `
-SecretKey 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

# Create a new Policy defining the policy document in a Here-String
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

# Create a new policy using a policy document defined in a JSON file
New-IAMPolicy -PolicyName "ListUsers" `
-PolicyDocument (Get-Content -Raw ListUserPolicy.json) `
-Description "This grants ListUsers permissions for all resources"

# View a specific policy
Get-IAMPolicy -PolicyArn "arn:aws:iam::940529233191:policy/ListUsers"

# ARN formats
#arn:partition:service:region:account-id:resource-id
#arn:partition:service:region:account-id:resource-type/resource-id
#arn:partition:service:region:account-id:resource-type:resource-id

# List all available policies
Get-IAMPolicies

# List and search for policies
Get-IAMPolicies | Where-Object {$_.PolicyName -match "List"} | Select-Object PolicyName,Arn

# Create ListUsers Group
New-IAMGroup -GroupName ListUsers

# Attach policy to group
Register-IAMGroupPolicy -GroupName ListUsers `
-PolicyArn "arn:aws:iam::940529233191:policy/ListUsers"

# Add user to ListUsers group
Add-IAMUserToGroup -UserName NoConsoleAccess -GroupName ListUsers

# List all IAM users with the context of the NoConsoleAccess user
Get-IAMUsers -AccessKey AKIA5V67JFUT27ZTTORG `
-SecretKey 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 | `
Select-Object UserName,Arn

# Policy with Dependent permissions
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



# Create an S3Bucket with the new RM user
New-S3Bucket -BucketName "RMBucket" `
-AccessKey $RMUserKey.AccessKeyId `
-SecretKey $RMUserKey.SecretAccessKey `
-Region eu-north-1

# Create an EC2 Instance with the new RM user
New-EC2Instance -



# List an IAM users permissions
Get-IAMUser NoConsoleAccess

# List policies attached to an IAM user
Get-IAMUserPolicyList NoConsoleAccess

