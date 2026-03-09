# Figure 9.30 - Run CreateADUser Script
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates using the CreateADUser.ps1 script for user provisioning.

# ============================================================================
# CREATE USER WITH SCRIPT
# ============================================================================

# Run the CreateADUser.ps1 script with required parameters
# The script handles username generation, password creation, and group assignment
.\CreateADUser.ps1 `
    -GivenName "john" `
    -SurName "Wilkins" `
    -JobTitle "Senior Developer" `
    -Department "Development" `
    -Country "DK" `
    -MobilePhone "+4532165487" `
    -Verbose

# ============================================================================
# VIEW GENERATED PASSWORD
# ============================================================================

# The script creates a password file for the new user
# The filename matches the generated username
Get-Content .\jowi.txt

# Expected Output: Random password like "aB3$xYz9!k"

# ============================================================================
# VERIFY USER CREATION
# ============================================================================

# Get the AD user with relevant properties
Get-ADUser jowi `
    -Properties EmailAddress, Title, Department, Country, Company, MemberOf, PasswordExpired

# Expected Output:
# Country           : DK
# Department        : Development
# EmailAddress      : jowi@moppleit.dk
# MemberOf          : {CN=EmployeesDK,...}
# PasswordExpired   : True    <-- User must change password at first login
# Title             : Senior Developer
# ...
