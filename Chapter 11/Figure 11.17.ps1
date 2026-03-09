# Figure 11.17 - Managing IAM Users (Get, Remove)
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Prerequisites: AWS.Tools.IdentityManagement, iam:GetUser, iam:DeleteUser permissions

# ============================================================================
# USER MANAGEMENT OPERATIONS
# ============================================================================

# This should be in the context of the new created RM user
# With the permissions from the RMGroup

# List another user (Test3) to verify they exist
Get-IAMUser Test3 | Select-Object UserName

# Expected Output:
# UserName
# --------
# Test3

# Remove the Test3 user - use -Confirm:$false to skip confirmation prompt
Remove-IAMUser Test3 -Confirm:$false

# List Test3 user after deletion - should produce an error
Get-IAMUser Test3 | Select-Object UserName

# Expected Output (Error):
# Get-IAMUser : The user with name Test3 cannot be found.
#
# NOTE: Before deleting a user, you may need to:
# 1. Delete their access keys (Remove-IAMAccessKey)
# 2. Delete their login profile (Remove-IAMLoginProfile)
# 3. Remove them from groups (Remove-IAMUserFromGroup)
# 4. Detach any inline policies
