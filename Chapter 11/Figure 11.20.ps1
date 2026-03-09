# Figure 11.20 - Filtering EC2 AMIs
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.EC2, ec2:DescribeImages permission

# ============================================================================
# FILTER AMIs WITH SPECIFIC CRITERIA
# ============================================================================

# Create a filter to find specific AMIs
# This example searches for Amazon Linux 2 AMIs
$Filter = @{
    Name = "architecture"; Values = "x86_64"
}, @{
    Name = "description"; Values = "Amazon Linux 2 AMI*"
}, @{
    Name = "is-public"; Values = "true"
}, @{
    Name = "state"; Values = "available"
}

# Count AMIs matching the filter - much more manageable
(Get-EC2Image -Region eu-north-1 -Filter $Filter).count

# Expected Output:
# 50-200 (varies as AWS releases new AMI versions)
#
# NOTE: Filters are essential when working with AMIs
# Common filters include:
#   - architecture: x86_64, arm64
#   - owner-id: Filter by AMI owner (e.g., Amazon's owner ID)
#   - name: AMI name pattern
#   - platform: windows (omit for Linux)
#   - root-device-type: ebs, instance-store
