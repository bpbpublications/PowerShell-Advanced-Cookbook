# Figure 11.24 - S3 Bucket Access Control with IAM Policies
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.S3, AWS.Tools.IdentityManagement, appropriate permissions

# ============================================================================
# S3 BUCKET ACCESS CONTROL DEMONSTRATION
# ============================================================================

# This example shows how to:
# 1. Create an IAM group with limited S3 access
# 2. Test permissions before and after group membership

# Policy for Get and Put objects in a specific bucket only
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

# ============================================================================
# TEST ACCESS WITHOUT GROUP MEMBERSHIP
# ============================================================================

# Start with an IAM user without access
# NOTE: This also requires the user to have permissions to list itself with
# iam:GetUser permission. This could be added to the policy or directly
# attached to the user before testing.
# Make sure you are in the context of this user (Set-AWSCredentials):
Get-IAMUser | Select-Object -ExpandProperty Username

# Try to write with the user without permission through the group membership
# This should fail with Access Denied
Write-S3Object -BucketName moppleit-access-limit -File C:\Temp\Books.xml

# ============================================================================
# SWITCH TO ADMIN AND ADD USER TO GROUP
# ============================================================================

# Clear credentials to switch to the user in the credentials file
Clear-AWSCredentials

# Double check you now have the context of an admin user
Get-IAMUser | Select-Object -ExpandProperty Username

# Add the IAM user to the group
Add-IAMUserToGroup -UserName Test2 -GroupName BucketAccess

# ============================================================================
# TEST ACCESS WITH GROUP MEMBERSHIP
# ============================================================================

# Set the context back to the user added to the group
# Replace <KEY> and <SECRET> with actual values
Set-AWSCredentials -AccessKey <KEY> -SecretKey <SECRET>

# Double check you now have the context of the user added to the group
Get-IAMUser | Select-Object -ExpandProperty Username

# Upload and download objects from the bucket - should now succeed
Write-S3Object -BucketName moppleit-access-limit -File C:\Temp\Books.xml
Read-S3Object -BucketName moppleit-access-limit -Key Data.zip -File C:\Temp\Test.zip

# Try to list bucket contents - should be denied (only Get/Put allowed)
Get-S3Bucket moppleit-access-limit

# Expected Output (Access Denied for listing):
# Get-S3Object : Access Denied
#
# NOTE: The policy only grants s3:GetObject and s3:PutObject
# Operations like s3:ListBucket are not included, demonstrating
# the principle of least privilege
