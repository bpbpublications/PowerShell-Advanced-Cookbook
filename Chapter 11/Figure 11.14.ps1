# Figure 11.14 - Searching for IAM Policies
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.IdentityManagement, iam:ListPolicies permission

# ============================================================================
# SEARCH FOR IAM POLICIES
# ============================================================================

# Expects you to be authenticated with a user with proper permissions
# Required permission: iam:ListPolicies

# List and search for policies matching a pattern
# Filter to show only policies with "List" in the name
Get-IAMPolicies | Where-Object { $_.PolicyName -match "List" } |
    Select-Object PolicyName, Arn

# Expected Output:
# PolicyName      Arn
# ----------      ---
# ListUsers       arn:aws:iam::123456789012:policy/ListUsers
# AWSListAllMyBuckets  arn:aws:iam::aws:policy/AWSListAllMyBuckets
#
# NOTE: AWS-managed policies have ARNs starting with arn:aws:iam::aws:policy/
# Customer-managed policies use arn:aws:iam::<account-id>:policy/
