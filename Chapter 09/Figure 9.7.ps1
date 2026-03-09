# Figure 9.7 - Modify AD User Attributes
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates modifying user attributes with Set-ADUser.

# ============================================================================
# UPDATE USER ATTRIBUTES
# ============================================================================

# Define attributes to update or add
# These are standard AD user properties with dedicated parameters
$Params = @{
    EmailAddress = "Moppleit@hotmail.com"
    Description  = "
    IT SystemAdministrator and DevOps at Energi Danmark A/S.
    Owner of Bio-Rent.dk
    Author"
    City         = "Ryomgaard"
    Country      = "DK"                    # Two-letter country code
    MobilePhone  = "+4512345678"
    SurName      = "Hansen"                # Correcting the surname
    DisplayName  = "Morten Hansen"         # Updating display name
}

# Apply the updates to the user
Set-ADUser -Identity "meh" @Params

# ============================================================================
# VERIFY MODIFICATIONS
# ============================================================================

# Retrieve the user with the modified properties
Get-ADUser meh -Properties DisplayName, EmailAddress, Description, City

# Expected Output:
# City              : Ryomgaard
# Description       : IT SystemAdministrator and DevOps at Energi Danmark A/S...
# DisplayName       : Morten Hansen
# EmailAddress      : Moppleit@hotmail.com
# ...
