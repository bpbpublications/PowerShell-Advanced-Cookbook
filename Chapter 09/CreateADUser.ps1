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

$ErrorActionPreference = "Stop"

function New-UserName {
    [CmdletBinding()]
    param (
        [String]$FullName
    )    
    
    $SplitName = ($FullName -split " ") | Select-Object -First 4

    # Create Initials
    do {
        switch ($SplitName.Length) {
            1 { $Init = -Join $SplitName[0][0..3] }
            2 { $Init = -Join ($SplitName[0][0..1] `
                + $SplitName[1][0..1]) }
            3 { $Init = -Join ($SplitName[0][0..1] `
                + $SplitName[1][0..0]) `
                + $SplitName[2][0..0] }
            4 { $Init = -Join ($SplitName[0][0..0] `
                + $SplitName[1][0..0]) `
                + $SplitName[2][0..0] `
                + $SplitName[3][0..0] }
        }

        try {
            Get-ADUser $Init | Out-Null
            $Exists = $true
            $SplitName[-1] = $SplitName[-1].Substring(1)
        }
        catch {
            $Exists = $false
        }
    } while ($Exists)
    return $Init.ToLower()
}
function Random-Pwd {
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
	
    $CharSet = ""
    if (-not $ExcludeUpperCase) { $CharSet += "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    if (-not $ExcludeLowerCase) { $CharSet += "abcdefghijklmnopqrstuvwxyz" }
    if (-not $ExcludeDigits) { $CharSet += "0123456789" }
    if (-not $ExcludeSpecialChars) { $CharSet += $SpecialChars }
	
    Write-Verbose "CharSet: $CharSet"
    $Password = -join (Get-Random -Count $Length -InputObject $CharSet.ToCharArray())
    Return $Password
   
}
function Select-CountryPath {
    param (
        [String]$Country
    )

    switch ($Country) {
        "DK" { return "OU=DK,OU=ADUsers,DC=moppleit,DC=dk" }
        "GB" { return "OU=GB,OU=ADUsers,DC=moppleit,DC=dk" }
        default { return "OU=ADUsers,DC=moppleit,DC=dk" }
    }
}

function Add-UserToCountryGroup {
    param (
        [String]$UserName,
        [ValidateSet("Dk","GB")]
        [String]$Country
    )
    try {
        switch ($Country) {
            "DK" { Add-ADGroupMember -Identity EmployeesDK -Members $UserName;
            Write-Verbose "User $UserName added to AD group: EmployeesDK" }
            "GB" { Add-ADGroupMember -Identity EmployeesGB -Members $UserName;
            Write-Verbose "User $UserName added to AD group: EmployeesGB" }
        }
    }
    catch {
        Write-Output "Could not add user $UserName to country specific AD Group"
    }
}

function New-PwdDoc {
    param (
        [String]$UserName,
        [String]$Password
    )

    $File = New-Item -ItemType file -Path ".\$UserName.txt" -Value "$($Password)"
    Write-Verbose "Created password document: $($File.FullName)" 
}

function Main {
    
    $FullName = "$($GivenName) $($SurName)"

    $UserName = New-UserName $FullName
    Write-Verbose "Calculated initials: $UserName"
    $Password = Random-Pwd -Length 10
    Write-Verbose "Created Random Password: XXXXXXXXXX"
    $CountryOU = Select-CountryPath $Country
    Write-Verbose "Selected Country OU: $CountryOU"

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
        ChangePasswordAtLogon = $true
    }

    try {
        New-ADUser @Params
        Write-Verbose "New AD User created: $UserName"
    }
    catch {
        Write-Output "Could not create new AD user: $UserName`r`n$($_)"
        Exit 1
    }

    # Perform other provisioning tasks!

    # Add DK employees to the EmployeesDK AD group and
    # GB employees to the EmployeesGB AD group.
    Add-UserToCountryGroup -UserName $UserName -Country $Country

    # Create password file
    New-PwdDoc -UserName $UserName -Password $Password

    # Create and associate mailbox with user.
    # Use API to create login to System XX.
    # etc...    
}

Main