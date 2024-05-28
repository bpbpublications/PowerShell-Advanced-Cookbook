# Create a new user with permission for EC2,S3, Secrets manager and for listing and deleting users
# Create the IAM user
$User = New-IAMUser -UserName RM

# Create access key for the user
$RMUserKey = New-IAMAccessKey -UserName $User.UserName

#Create the IAM group
$Group = New-IAMGroup -GroupName RMGroup

# Add the user to the group
Add-IAMUserToGroup -UserName $User.UserName `
-GroupName $Group.GroupName

# Create a policy that have permissions to delete a user
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

$NewCustomPolicy = New-IAMPolicy -PolicyName "RMPolicy" `
-PolicyDocument $CustomPolicy `
-Description "This grants custom permissions"

# Define relevant policies
$Policies = @(
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    "$($NewCustomPolicy.Arn)"
)

foreach ($Policy in $Policies){
    Register-IAMGroupPolicy -GroupName $Group.GroupName `
-PolicyArn $Policy
}

Set-AWSCredentials -AccessKey $RMUserKey.AccessKeyId `
-SecretKey $RMUserKey.SecretAccessKey

# AccessKeyId     : AKIA5V67JFUTZUD4L5EI
# CreateDate      : 02-11-2023 19:50:50
# SecretAccessKey : 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
# Status          : Active
# UserName        : RM

#Set-AWSCredentials -AccessKey AKIA5V67JFUTZUD4L5EI `
#-SecretKey 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