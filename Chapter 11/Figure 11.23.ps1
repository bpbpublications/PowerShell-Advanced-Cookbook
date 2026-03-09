# Figure 11.23 - S3 Bucket Operations (Create, Upload, Download, Delete)
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.S3, appropriate S3 permissions

# ============================================================================
# COMPLETE S3 BUCKET LIFECYCLE
# ============================================================================

# It is easy to create and manage buckets
# NOTE: Bucket names must be globally unique across all AWS accounts

$Region = "eu-north-1"
$BucketName = "moppleit-s3"

# Create a new S3 bucket
New-S3Bucket -BucketName $BucketName -Region $Region

# Upload a file to the bucket
Write-S3Object -BucketName $BucketName `
    -File "C:\Temp\Data.zip"

# Download a file from the bucket with a new name
Read-S3Object -BucketName $BucketName `
    -Key "Data.zip" `
    -File "C:\Temp\NewData.zip"

# Delete the bucket and all its contents
# -DeleteBucketContent removes all objects before deleting the bucket
Remove-S3Bucket -BucketName $BucketName `
    -DeleteBucketContent `
    -Force

# Verify the bucket is deleted - should return nothing or error
Get-S3Bucket $BucketName

# Expected Output (after deletion):
# Get-S3Bucket : The specified bucket does not exist
#
# NOTE: Use -DeleteBucketContent carefully - it permanently deletes all objects
# Consider enabling versioning and lifecycle policies for production buckets
