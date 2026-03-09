# Figure 11.3 - Unauthenticated AWS Access Error
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.S3 module installed

# ============================================================================
# ATTEMPTING AWS ACCESS WITHOUT AUTHENTICATION
# ============================================================================

# Expect the required AWS.Tools.S3 module to be installed
# This demonstrates what happens when you are NOT authenticated to AWS
# Running AWS commands without credentials produces an authentication error

Get-S3Bucket

# Expected Output (Error):
# Get-S3Bucket : No credentials specified or obtained from persisted/shell defaults.
# At line:1 char:1
# + Get-S3Bucket
# + ~~~~~~~~~~~~
#     + CategoryInfo          : InvalidOperation: (Amazon.PowerShe...etS3BucketCmdlet:GetS3BucketCmdlet) [Get-S3Bucket], InvalidOperationException
#     + FullyQualifiedErrorId : InvalidOperationException,Amazon.PowerShell.Cmdlets.S3.GetS3BucketCmdlet
#
# NOTE: You must configure credentials before accessing AWS services
# See Figure 11.4 for IAM user creation in the AWS Console
