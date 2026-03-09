# Figure 9.11 - Create a New AD Group
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates creating an AD group using parameter splatting.

# ============================================================================
# CREATE NEW AD GROUP
# ============================================================================

# Define group parameters in a hashtable
$Params = @{
    Name        = "TestServerAccess"
    DisplayName = "TestServerAccess"
    GroupScope  = "Global"                                    # Global, DomainLocal, or Universal
    Path        = "OU=Custom,OU=ADGroups,DC=moppleit,DC=dk"   # Target OU
    Description = "Grants access to all test servers"
}

# Create the group
New-ADGroup @Params

# ============================================================================
# VERIFY GROUP CREATION
# ============================================================================

# Get the newly created AD group with additional properties
Get-ADGroup -Identity TestServerAccess -Properties Description, DisplayName

# Expected Output:
# Description       : Grants access to all test servers
# DisplayName       : TestServerAccess
# DistinguishedName : CN=TestServerAccess,OU=Custom,OU=ADGroups,DC=moppleit,DC=dk
# GroupCategory     : Security
# GroupScope        : Global
# Name              : TestServerAccess
# ...

# ============================================================================
# GROUP SCOPE REFERENCE
# ============================================================================

# Global:      Can contain users from same domain, can be member of other groups
# DomainLocal: Can contain users from any domain, used for resource permissions
# Universal:   Can contain users from any domain in forest, replicated to GC
