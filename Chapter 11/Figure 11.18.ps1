# Figure 11.18 - Creating a Secret in AWS Secrets Manager
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.SecretsManager, secretsmanager:CreateSecret permission

# ============================================================================
# CREATE SECRET IN SECRETS MANAGER
# ============================================================================

# Use the context of the RM user to create a new secret in Secrets Manager
# Requires the AWS.Tools.SecretsManager module to be installed
# Install-AWSToolsModule AWS.Tools.SecretsManager

New-SECSecret -Name "TestSecret" -SecretString "VerySecret" -Region eu-north-1

# Expected Output:
# ARN             : arn:aws:secretsmanager:eu-north-1:123456789012:secret:TestSecret-AbCdEf
# Name            : TestSecret
# ReplicationStatus :
# VersionId       : 12345678-1234-1234-1234-123456789012
#
# NOTE: Secrets Manager provides secure storage for credentials, API keys,
# and other sensitive data. Secrets can be automatically rotated and
# are encrypted at rest using AWS KMS.
#
# To retrieve the secret later:
# Get-SECSecretValue -SecretId "TestSecret" -Region eu-north-1
