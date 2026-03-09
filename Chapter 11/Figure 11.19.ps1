# Figure 11.19 - Counting Available EC2 AMIs
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.EC2, ec2:DescribeImages permission

# ============================================================================
# COUNT ALL AVAILABLE AMIs
# ============================================================================

# Count all Amazon Machine Images (AMIs) available in the specified region
# WARNING: This returns a VERY large number as it includes all public AMIs
(Get-EC2Image -Region eu-north-1).count

# Expected Output:
# 150000+ (varies by region and time)
#
# NOTE: The count includes all public, private, and shared AMIs
# This is typically too many to be useful without filtering
# See Figure 11.20 for how to filter AMIs effectively
