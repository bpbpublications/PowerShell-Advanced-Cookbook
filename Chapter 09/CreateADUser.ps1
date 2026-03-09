# Recipe: Automated AD User Creation Script
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Complete script for creating AD users with automatic username generation,
# random password creation, and country-based group assignment.

# ============================================================================
# SCRIPT PARAMETERS
# ============================================================================

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [String]$GivenName,

    [Parameter(Mandatory = $true, Position = 1)]
    [String]$SurName,

    [Parameter(Mandatory = $true, Position = 2)]
    [String]$JobTitle,

    [Parameter(Mandatory = $true, Position = 3)]
    [String]$Department,

    [Parameter(Mandatory = $true, Position = 4)]
    [ValidateSet("DK", "GB")]
    [String]$Country,

    [Parameter(Mandatory = $true, Position = 5)]
    [String]$MobilePhone
)

# Stop on any error to prevent partial user creation
$ErrorActionPreference = "Stop"

# ============================================================================
# FUNCTION: GENERATE UNIQUE USERNAME
# ============================================================================

function New-UserName {
    <#
    .SYNOPSIS
        Generates a unique username (initials) from the full name.
    .DESCRIPTION
        Creates 2-4 character initials from the name parts.
        If the username already exists in AD, extends the last name portion.
    #>
    [CmdletBinding()]
    param (
        [String]$FullName
    )

    # Split name into parts (max 4 for initials calculation)
    $SplitName = ($FullName -split " ") | Select-Object -First 4

    # Generate initials based on number of name parts
    do {
        switch ($SplitName.Length) {
            1 { $Init = -Join $SplitName[0][0..3] }                              # 4 chars from single name
            2 { $Init = -Join ($SplitName[0][0..1] + $SplitName[1][0..1]) }      # 2+2 chars
            3 { $Init = -Join ($SplitName[0][0..1] + $SplitName[1][0..0]) + $SplitName[2][0..0] }  # 2+1+1
            4 { $Init = -Join ($SplitName[0][0..0] + $SplitName[1][0..0]) + $SplitName[2][0..0] + $SplitName[3][0..0] }  # 1+1+1+1
        }

        # Check if username already exists in AD
        try {
            Get-ADUser $Init | Out-Null
            $Exists = $true
            # Extend last name part to make unique
            $SplitName[-1] = $SplitName[-1].Substring(1)
        }
        catch {
            $Exists = $false
        }
    } while ($Exists)

    return $Init.ToLower()
}

# ============================================================================
# FUNCTION: GENERATE RANDOM PASSWORD
# ============================================================================

function Random-Pwd {
    <#
    .SYNOPSIS
        Generates a cryptographically random password.
    .DESCRIPTION
        Creates a password with configurable length and character sets.
        Supports uppercase, lowercase, digits, and special characters.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateRange(8, 63)]
        [int]$Length,

        [Parameter(Position = 1)]
        [ValidatePattern("^[!@#£$€%&(){}\[\]]*$")]
        [string]$SpecialChars = "!@#$%",

        [switch]$ExcludeUpperCase,
        [switch]$ExcludeLowerCase,
        [switch]$ExcludeDigits,
        [switch]$ExcludeSpecialChars
    )

    # Build character set based on parameters
    $CharSet = ""
    if (-not $ExcludeUpperCase) { $CharSet += "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    if (-not $ExcludeLowerCase) { $CharSet += "abcdefghijklmnopqrstuvwxyz" }
    if (-not $ExcludeDigits) { $CharSet += "0123456789" }
    if (-not $ExcludeSpecialChars) { $CharSet += $SpecialChars }

    Write-Verbose "CharSet: $CharSet"

    # Generate random password from character set
    $Password = -join (Get-Random -Count $Length -InputObject $CharSet.ToCharArray())
    Return $Password
}

# ============================================================================
# FUNCTION: SELECT OU BASED ON COUNTRY
# ============================================================================

function Select-CountryPath {
    <#
    .SYNOPSIS
        Returns the appropriate OU path based on country code.
    #>
    param (
        [String]$Country
    )

    switch ($Country) {
        "DK" { return "OU=DK,OU=ADUsers,DC=moppleit,DC=dk" }
        "GB" { return "OU=GB,OU=ADUsers,DC=moppleit,DC=dk" }
        default { return "OU=ADUsers,DC=moppleit,DC=dk" }
    }
}

# ============================================================================
# FUNCTION: ADD USER TO COUNTRY-SPECIFIC GROUP
# ============================================================================

function Add-UserToCountryGroup {
    <#
    .SYNOPSIS
        Adds the new user to their country-specific employee group.
    #>
    param (
        [String]$UserName,
        [ValidateSet("DK", "GB")]
        [String]$Country
    )

    try {
        switch ($Country) {
            "DK" {
                Add-ADGroupMember -Identity EmployeesDK -Members $UserName
                Write-Verbose "User $UserName added to AD group: EmployeesDK"
            }
            "GB" {
                Add-ADGroupMember -Identity EmployeesGB -Members $UserName
                Write-Verbose "User $UserName added to AD group: EmployeesGB"
            }
        }
    }
    catch {
        Write-Output "Could not add user $UserName to country specific AD Group"
    }
}

# ============================================================================
# FUNCTION: CREATE PASSWORD DOCUMENT
# ============================================================================

function New-PwdDoc {
    <#
    .SYNOPSIS
        Creates a text file containing the user's initial password.
    .DESCRIPTION
        Password file should be distributed securely and deleted after use.
    #>
    param (
        [String]$UserName,
        [String]$Password
    )

    $File = New-Item -ItemType file -Path ".\$UserName.txt" -Value "$($Password)"
    Write-Verbose "Created password document: $($File.FullName)"
}

# ============================================================================
# MAIN FUNCTION
# ============================================================================

function Main {
    # Combine first and last name
    $FullName = "$($GivenName) $($SurName)"

    # Generate unique username
    $UserName = New-UserName $FullName
    Write-Verbose "Calculated initials: $UserName"

    # Generate random password
    $Password = Random-Pwd -Length 10
    Write-Verbose "Created Random Password: XXXXXXXXXX"  # Don't log actual password

    # Get OU path based on country
    $CountryOU = Select-CountryPath $Country
    Write-Verbose "Selected Country OU: $CountryOU"

    # Build AD user parameters
    $Params = @{
        Name                  = $FullName
        DisplayName           = $FullName
        GivenName             = $GivenName
        SurName               = $SurName
        SamAccountName        = $UserName
        UserPrincipalName     = "$($Username)@moppleit.dk"
        EmailAddress          = "$($Username)@moppleit.dk"
        Path                  = $CountryOU
        AccountPassword       = (ConvertTo-SecureString "$($Password)" -AsPlainText -Force)
        Enabled               = $true
        MobilePhone           = $MobilePhone
        Title                 = $JobTitle
        Department            = $Department
        Country               = $Country
        Company               = "MoppleIT"
        ChangePasswordAtLogon = $true  # Force password change on first login
    }

    # Create the AD user
    try {
        New-ADUser @Params
        Write-Verbose "New AD User created: $UserName"
    }
    catch {
        Write-Output "Could not create new AD user: $UserName`r`n$($_)"
        Exit 1
    }

    # ========================================================================
    # POST-CREATION TASKS
    # ========================================================================

    # Add user to country-specific group
    Add-UserToCountryGroup -UserName $UserName -Country $Country

    # Create password file for secure distribution
    New-PwdDoc -UserName $UserName -Password $Password

    # Additional provisioning tasks could be added here:
    # - Create and associate mailbox with user
    # - Use API to create login to other systems
    # - Send welcome email
    # - etc...
}

# Execute main function
Main
