# Figure 9.9 - Disable AD User Account
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates multiple ways to disable an AD user account.

# ============================================================================
# METHOD 1: DISABLE-ADACCOUNT WITH IDENTITY
# ============================================================================

# Use Disable-ADAccount with the -Identity parameter
Disable-ADAccount -Identity "meh"

# ============================================================================
# METHOD 2: DISABLE-ADACCOUNT WITH PIPELINE
# ============================================================================

# Use Get-ADUser piped to Disable-ADAccount
# Useful for disabling multiple users based on a filter
Get-ADUser "meh" | Disable-ADAccount

# ============================================================================
# METHOD 3: SET-ADUSER WITH ENABLED PARAMETER
# ============================================================================

# Use Set-ADUser with -Enabled $false
# Same result but different cmdlet
Set-ADUser -Identity "meh" -Enabled $false

# ============================================================================
# VERIFY ACCOUNT STATUS
# ============================================================================

# Check the user's Enabled state after disabling
Get-ADUser meh

# Expected Output:
# DistinguishedName : CN=Morten E. Hansen,OU=DK,OU=ADUsers,DC=moppleit,DC=dk
# Enabled           : False    <-- Account is now disabled
# ...
