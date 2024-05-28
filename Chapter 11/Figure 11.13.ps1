# This should be created with a user with permissions to create policies
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