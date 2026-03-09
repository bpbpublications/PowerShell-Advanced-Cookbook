# Recipe: AWS S3 Bucket and Object Management
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates complete S3 bucket lifecycle including object operations
# and access control through IAM policies.

# ============================================================================
# CONFIGURATION
# ============================================================================

$Region = "eu-north-1"

# ============================================================================
# DISCOVER S3 CMDLETS
# ============================================================================

# List all S3 cmdlets available
Get-Command | Where-Object { $_.Name -match "S3" }

# ============================================================================
# BUCKET CREATION
# ============================================================================

# Create a new S3 Bucket
# NOTE: Bucket names must be globally unique across ALL AWS accounts
New-S3Bucket `
    -BucketName "moppleit-test-bucket" `
    -Region $Region

# ============================================================================
# LIST BUCKETS
# ============================================================================

# List all S3 Buckets in an account across all regions
Get-S3Bucket

# ============================================================================
# BUCKET PROPERTIES
# ============================================================================

# Get bucket Access Control List (ACL)
Get-S3ACL -BucketName moppleit-test-bucket

# Get bucket encryption scheme
Get-S3BucketEncryption moppleit-test-bucket

# Get bucket location (Region)
Get-S3BucketLocation moppleit-test-bucket

# Get bucket attached policies
Get-S3BucketPolicy moppleit-test-bucket

# Get bucket tags
Get-S3BucketTagging moppleit-test-bucket

# ============================================================================
# UPLOAD OBJECTS
# ============================================================================

# Upload a file to bucket (uses filename as key)
Write-S3Object -BucketName moppleit-test-bucket `
    -File "C:\Temp\Data.zip"

# Upload a file to a specific key (path) in the bucket
Write-S3Object -BucketName moppleit-test-bucket `
    -File "C:\Temp\MoreData.zip" `
    -Key "ZipFiles/MoreData/MoreData.zip"

# Upload another file to a specific path
Write-S3Object -BucketName moppleit-test-bucket `
    -File "C:\Temp\MostData.zip" `
    -Key "ZipFiles/MoreData/MostData.zip"

# Upload an entire folder to a bucket
Write-S3Object -BucketName moppleit-test-bucket `
    -Folder "C:\Temp\Files" `
    -KeyPrefix "Temp/Files" `
    -Recurse

# ============================================================================
# LIST OBJECTS
# ============================================================================

# List all objects in an S3 bucket
Get-S3Object -BucketName moppleit-test-bucket

# List a specific object in an S3 bucket
Get-S3Object -BucketName moppleit-test-bucket `
    -Key "Temp/Files/Books.xml"

# List all objects in a specific key prefix (folder)
Get-S3Object -BucketName moppleit-test-bucket `
    -KeyPrefix "Temp/Files"

# ============================================================================
# DOWNLOAD OBJECTS
# ============================================================================

# Download a specific file from a bucket
Read-S3Object -BucketName moppleit-test-bucket `
    -Key "Temp/Files/Books.xml" `
    -File "C:\Temp\Books.xml"

# Download all content from a key prefix (folder) in a bucket
Read-S3Object -BucketName moppleit-test-bucket `
    -KeyPrefix "Temp/Files" `
    -Folder "C:\Temp\NewTemp"

# ============================================================================
# DELETE OBJECTS
# ============================================================================

# Delete a specific file in a bucket
Remove-S3Object -BucketName moppleit-test-bucket `
    -Key "Temp/Files/Books.xml" `
    -Confirm:$false

# Delete a folder (all objects with matching prefix) in a bucket
Get-S3Object -BucketName moppleit-test-bucket `
    -KeyPrefix "Temp/Files" |
    Remove-S3Object `
    -Force

# Delete an S3 bucket (including all contents)
Remove-S3Bucket -BucketName moppleit-test-bucket `
    -DeleteBucketContent `
    -Force

# ============================================================================
# COMPLETE BUCKET LIFECYCLE EXAMPLE
# ============================================================================

$BucketName = "moppleit-s3"

# Create a new bucket
New-S3Bucket -BucketName $BucketName -Region $Region

# Upload a file to the bucket
Write-S3Object -BucketName $BucketName `
    -File "C:\Temp\Data.zip"

# Download the file with a new name
Read-S3Object -BucketName $BucketName `
    -Key "Data.zip" `
    -File "C:\Temp\NewData.zip"

# Delete the bucket and all its contents
Remove-S3Bucket -BucketName $BucketName `
    -DeleteBucketContent `
    -Force

# ============================================================================
# ACCESS CONTROL WITH IAM POLICIES
# ============================================================================

# Create a new IAM Group for bucket access
New-IAMGroup -GroupName BucketAccess

# Create a new S3 bucket for access control demonstration
New-S3Bucket -BucketName moppleit-access-limit `
    -Region eu-north-1

# Policy for Get and Put objects in a specific bucket only
# Note: This does NOT grant list permissions
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
# NOTES
# ============================================================================

# S3 Terminology:
# - Bucket: Container for objects (like a root folder)
# - Object: A file stored in a bucket
# - Key: The unique identifier (path) for an object within a bucket
# - Key Prefix: A partial key used to organize objects (like folders)
#
# Bucket Naming Rules:
# - Must be globally unique across all AWS accounts
# - 3-63 characters long
# - Lowercase letters, numbers, and hyphens only
# - Must start with a letter or number
# - Cannot be formatted as an IP address
#
# Best Practices:
# - Enable versioning for important data
# - Use lifecycle policies to manage storage costs
# - Enable server-side encryption for sensitive data
# - Use bucket policies and IAM policies for access control
# - Enable access logging for audit purposes
