# Figure 9.6 - Create a New AD User with Splatting
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates creating an AD user using parameter splatting.

# ============================================================================
# CREATE NEW AD USER WITH SPLATTING
# ============================================================================

# Define all parameters in a hashtable for better readability
$Params = @{
    Name              = "Morten E. Hansen"
    GivenName         = "Morten"
    SurName           = "E. Hansen"
    DisplayName       = "Morten E. Hansen"
    SamAccountName    = "meh"                          # Max 20 characters (legacy limit)
    UserPrincipalName = "meh@moppleit.dk"              # Used for modern authentication
    Path              = "OU=DK,OU=ADUsers,DC=moppleit,DC=dk"  # Target OU
    AccountPassword   = (ConvertTo-SecureString "Pa$$w0rd" -AsPlainText -Force)
    Enabled           = $true                          # Account is active immediately
    OtherAttributes   = @{
        Info            = "Administrator, Developer and DevOps"
        TelephoneNumber = "+4512345678"
    }
}

# Create the user with splatting (@Params instead of $Params)
New-ADUser @Params

# ============================================================================
# VERIFY USER CREATION
# ============================================================================

# List the newly created AD User with additional properties
# Note: Most properties require -Properties parameter to retrieve
Get-ADUser meh -Properties Info, TelephoneNumber, DisplayName

# Expected Output:
# DistinguishedName : CN=Morten E. Hansen,OU=DK,OU=ADUsers,DC=moppleit,DC=dk
# DisplayName       : Morten E. Hansen
# Enabled           : True
# GivenName         : Morten
# Info              : Administrator, Developer and DevOps
# Name              : Morten E. Hansen
# ...
