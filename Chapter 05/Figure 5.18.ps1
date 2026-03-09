# Figure 5.18 - Unsigned Script with AllSigned Policy Note
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This script demonstrates what happens when trying to run an unsigned
# script with the execution policy set to AllSigned.
#
# Platform: Windows only (Execution Policy)

# ============================================================================
# EXECUTION POLICY REQUIREMENT
# ============================================================================

# Execution policy should be set to AllSigned.
# Note that changes to the execution policy requires administrator privileges
#
# Set the policy (requires elevation):
# Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope LocalMachine
#
# Or for current user only (no elevation needed):
# Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope CurrentUser

# ============================================================================
# SCRIPT CONTENT
# ============================================================================

Write-Output "I need to sign this script!"

# ============================================================================
# EXPECTED ERROR (AllSigned Policy, Unsigned Script)
# ============================================================================

# When running this script with AllSigned policy:
#
# .\Figure 5.18.ps1 : File .\Figure 5.18.ps1 cannot be loaded.
# The file .\Figure 5.18.ps1 is not digitally signed.
# You cannot run this script on the current system.
# For more information about running scripts and setting execution policy,
# see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.
#     + CategoryInfo          : SecurityError: (:) [], PSSecurityException
#     + FullyQualifiedErrorId : UnauthorizedAccess

# ============================================================================
# SOLUTION
# ============================================================================

# To run this script with AllSigned policy, you must sign it:
# 1. Get a code signing certificate (see Figure 5.12)
# 2. Sign the script (see Figure 5.16)
# 3. Run the signed script

# Or temporarily change execution policy:
# Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
# (Only affects the current PowerShell session)

