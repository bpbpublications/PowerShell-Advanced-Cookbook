# Figure 11.22 - List All S3 Buckets
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.S3, s3:ListAllMyBuckets permission

# ============================================================================
# LIST S3 BUCKETS
# ============================================================================

# Expects you to be authenticated with a user with proper permissions
# Required permission: s3:ListAllMyBuckets

# List all S3 buckets across all regions in the account
Get-S3Bucket

# Expected Output:
# BucketName                         CreationDate
# ----------                         ------------
# my-data-bucket                     01/15/2023 10:30:00
# my-backup-bucket                   03/20/2023 14:45:00
# my-logs-bucket                     06/10/2023 08:15:00
#
# NOTE: S3 buckets are global resources but stored in specific regions
# The bucket name must be globally unique across all AWS accounts
# Use Get-S3BucketLocation to find which region a bucket is in
