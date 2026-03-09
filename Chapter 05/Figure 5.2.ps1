# Figure 5.2 - Password Generator with Parameter Validation
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This enhances Figure 5.1 by adding parameter validation attributes.
# Validation prevents invalid input before the script runs.

[CmdletBinding()]
param (
    # ValidateRange ensures length is between 8 and 63 characters
    # Attempting values outside this range throws an error
    [ValidateRange(8, 63)]
    [int]$Length = 12,

    # ValidatePattern uses regex to restrict allowed special characters
    # Only allows: ! @ # £ $ € % & ( ) { } [ ]
    # Using ^ and $ ensures the ENTIRE string matches the pattern
    [ValidatePattern("^[!@#£$€%&(){}\[\]]*$")]
    [string]$SpecialChars = "!@#$%",

    [switch]$ExcludeUpperCase,
    [switch]$ExcludeLowerCase,
    [switch]$ExcludeDigits,
    [switch]$ExcludeSpecialChars
)

# ============================================================================
# BUILD CHARACTER SET
# ============================================================================

$charSet = ""
if (-not $ExcludeUpperCase) { $charSet += "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
if (-not $ExcludeLowerCase) { $charSet += "abcdefghijklmnopqrstuvwxyz" }
if (-not $ExcludeDigits) { $charSet += "0123456789" }
if (-not $ExcludeSpecialChars) { $charSet += $SpecialChars }

# ============================================================================
# GENERATE PASSWORD
# ============================================================================

Write-Verbose "Charset: $CharSet"
$password = -join (Get-Random -Count $Length -InputObject $charSet.ToCharArray())
$password

# ============================================================================
# VALIDATION ATTRIBUTES EXPLAINED
# ============================================================================

# VALIDATERANGE(min, max):
# - Restricts numeric parameters to specified range
# - Error: "Cannot validate argument on parameter 'Length'..."

# VALIDATEPATTERN(regex):
# - Tests string against regular expression
# - Must match entire string (use ^ and $)
# - Error: "Cannot validate argument on parameter 'SpecialChars'..."

# OTHER VALIDATION ATTRIBUTES:
# - [ValidateSet("A","B","C")]   : Only allows listed values
# - [ValidateNotNullOrEmpty()]  : Rejects null or empty strings
# - [ValidateLength(min, max)]  : String length validation
# - [ValidateCount(min, max)]   : Array element count
# - [ValidateScript({...})]     : Custom validation logic

# ============================================================================
# USAGE AND VALIDATION TESTING
# ============================================================================

# Valid: Length 20, all default special chars
# .\Figure 5.2.ps1 -Length 20 -SpecialChars "!@#£$€%&(){}[]"

# INVALID: Length too short (must be 8-63)
# .\Figure 5.2.ps1 -Length 6
# Error: Cannot validate argument on parameter 'Length'. The 6 argument
#        is less than the minimum allowed range of 8.

# INVALID: Special chars contain letters
# .\Figure 5.2.ps1 -Length 8 -SpecialChars "ABC"
# Error: Cannot validate argument on parameter 'SpecialChars'. The argument
#        "ABC" does not match the pattern...

# Expected Output (valid input):
# nK#8mPw2@€Q4pL!9 (random password)
