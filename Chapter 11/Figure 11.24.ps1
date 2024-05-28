 # Checking permissions by creating a bucket uploading and downloading files
 # and then removing the bucket in the context of users with group membership
 # with this policy only

 # Policy for Get and Put objects in the bucket
$AccessPolicy = @"
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::moppleit-access-limit/*"
        }
    ]
}
"@

# Create the new policy
$GroupPolicy = New-IAMPolicy -PolicyName "AccessS3-moppleit-access-limit" `
-PolicyDocument $AccessPolicy `
-Description "This grants Get/Put on S3 moppleit-access-limit"

# Attach the policy to the IAM group
Register-IAMGroupPolicy -GroupName "BucketAccess" `
-PolicyArn $GroupPolicy.Arn

# Start with an IAM user without access

# List the user
# NOTE this also requires the user to have permissions to list itself with the
# iam:GetUser permissions
# This could be added to the policy or directly atatched to the user before 
# Testing the following code. Make sure you are in the context of this user (Set-AWSCredentials):
Get-IAMUser | Select-Object -ExpandProperty Username

# Try to write with the user without permission through the group membership
Write-S3Object -BucketName moppleit-access-limit -File C:\Temp\Books.xml

# Clear credentials to switch to the user in the credentials file
Clear-AWSCredentials

# Double check you now have the context of an admin user to add the other user to the new group
Get-IAMUser | Select-Object -ExpandProperty Username

# Add the IAM user to the group
Add-IAMUserToGroup -UserName Test2 -GroupName BucketAccess

# Set the context back to the user added to the group
Set-AWSCredentials -AccessKey <KEY> -SecretKey <SECRET>

# Double check you now have the context of the user added to the group
Get-IAMUser | Select-Object -ExpandProperty Username

# Upload and download objects from the bucket
Write-S3Object -BucketName moppleit-access-limit -File C:\Temp\Books.xml
read-S3Object -BucketName moppleit-access-limit -Key Data.zip -File c:\temp\Test.zip

# Try to access all content in the bucket (Should be denied)
Get-S3Bucket moppleit-access-limit


