# Recipe: Bulk AD User Creation from CSV
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Creates multiple AD users from a CSV file using the CreateADUser.ps1 script.

# ============================================================================
# SCRIPT PARAMETERS
# ============================================================================

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [String]$CsvFilePath
)

# Stop on any error
$ErrorActionPreference = "Stop"

# ============================================================================
# MAIN FUNCTION
# ============================================================================

function Main {
    # Import CSV file with semicolon delimiter
    # Expected columns: GivenName, SurName, JobTitle, Department, Country, MobilePhone
    $CsvContent = Import-Csv $CsvFilePath -Delimiter ";"

    # Process each row in the CSV
    foreach ($User in $CsvContent) {
        # Build parameters for CreateADUser.ps1
        $Params = @{
            GivenName   = $User.GivenName
            SurName     = $User.SurName
            JobTitle    = $User.JobTitle
            Department  = $User.Department
            Country     = $User.Country
            MobilePhone = $User.MobilePhone
        }

        # Call the individual user creation script
        try {
            .\CreateADUser.ps1 @Params
            Write-Verbose "Created user for: $($User.GivenName) $($User.SurName)"
        }
        catch {
            Write-Output "Could not create user: $($User.GivenName) $($User.SurName)"
            $_
        }
    }
}

# Execute main function
Main

# ============================================================================
# USAGE
# ============================================================================

# .\CreateBulkADUsers.ps1 -CsvFilePath .\BulkUsers.csv -Verbose

# ============================================================================
# CSV FILE FORMAT
# ============================================================================

# The CSV file must have a header row with these columns:
# GivenName;SurName;JobTitle;Department;Country;MobilePhone
#
# Example:
# GivenName;SurName;JobTitle;Department;Country;MobilePhone
# John;Doe;Developer;IT;DK;+4512345678
# Jane;Smith;Manager;HR;GB;+4498765432

# ============================================================================
# NOTES
# ============================================================================

# - CreateADUser.ps1 must be in the same directory
# - The script uses semicolon (;) as CSV delimiter
# - Each user creation generates a password file
# - Failed user creations are logged but don't stop the batch
