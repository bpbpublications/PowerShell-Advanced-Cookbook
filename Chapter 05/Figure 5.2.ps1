[CmdletBinding()]
param (
    [ValidateRange(8, 63)]
    [int]$Length = 12,

    [ValidatePattern("^[!@#£$€%&(){}\[\]]*$")]
    [string]$SpecialChars = "!@#$%",
    
    [switch]$ExcludeUpperCase,
    [switch]$ExcludeLowerCase,
    [switch]$ExcludeDigits,
    [switch]$ExcludeSpecialChars
)

$charSet = ""
if (-not $ExcludeUpperCase) { $charSet += "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
if (-not $ExcludeLowerCase) { $charSet += "abcdefghijklmnopqrstuvwxyz" }
if (-not $ExcludeDigits) { $charSet += "0123456789" }
if (-not $ExcludeSpecialChars) { $charSet += $SpecialChars }

Write-Verbose "Charset: $CharSet"
$password = -join (Get-Random -Count $Length -InputObject $charSet.ToCharArray())
$password

# Invoked with invalid SpecialChars argument.
# .\RandomPass.ps1 -Length 8 -SpecialChars "ABC"

# Invoked with invalid Length argument
# .\RandomPass.ps1 -Length 6 -SpecialChars "!@#£$€%&(){}[]"

# Invoked with valid arguments
# # .\RandomPass.ps1 -Length 20 -SpecialChars "!@#£$€%&(){}[]"