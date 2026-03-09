# Figure 11.5 - Finding IAM User Cmdlets
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.IdentityManagement module installed

# ============================================================================
# DISCOVER IAM USER CMDLETS
# ============================================================================

# List and view AWS IAM User cmdlets
# This helps discover what operations are available for user management
Get-Command | Where-Object { $_.Name -match "IAMuser" }

# Expected Output:
# CommandType     Name                       Version    Source
# -----------     ----                       -------    ------
# Cmdlet          Get-IAMUser                4.x.x.x    AWS.Tools.IdentityManagement
# Cmdlet          Get-IAMUserList            4.x.x.x    AWS.Tools.IdentityManagement
# Cmdlet          Get-IAMUserPolicy          4.x.x.x    AWS.Tools.IdentityManagement
# Cmdlet          Get-IAMUserPolicyList      4.x.x.x    AWS.Tools.IdentityManagement
# Cmdlet          Get-IAMUserTagList         4.x.x.x    AWS.Tools.IdentityManagement
# Cmdlet          New-IAMUser                4.x.x.x    AWS.Tools.IdentityManagement
# Cmdlet          Remove-IAMUser             4.x.x.x    AWS.Tools.IdentityManagement
# Cmdlet          Update-IAMUser             4.x.x.x    AWS.Tools.IdentityManagement
