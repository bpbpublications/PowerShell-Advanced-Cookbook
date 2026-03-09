# Figure 9.10 - Delete AD User Account
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates multiple ways to delete an AD user account.

# ============================================================================
# METHOD 1: REMOVE-ADUSER WITH IDENTITY
# ============================================================================

# Delete using -Identity parameter (will prompt for confirmation)
Remove-ADUser -Identity "meh"

# ============================================================================
# METHOD 2: REMOVE-ADUSER WITH PIPELINE
# ============================================================================

# Delete using Get-ADUser piped to Remove-ADUser
Get-ADUser "meh" | Remove-ADUser

# ============================================================================
# METHOD 3: REMOVE-ADUSER WITHOUT CONFIRMATION
# ============================================================================

# Skip the confirmation prompt with -Confirm:$false
# Use with caution - no undo!
Remove-ADUser -Identity "meh" -Confirm:$false

# ============================================================================
# VERIFY DELETION
# ============================================================================

# Attempting to get the user after deletion will result in an error
Get-ADUser meh

# Expected Output:
# Get-ADUser: Cannot find an object with identity: 'meh' ...
