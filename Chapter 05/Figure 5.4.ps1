# Figure 5.4 - Password Generator with Positioned Parameters
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates using positional parameters for concise command invocation.
# Position attributes allow passing values without naming the parameter.

[CmdletBinding()]
param (
    # Position = 0: First unnamed argument goes to this parameter
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateRange(8, 63)]
    [int]$Length,

    # Position = 1: Second unnamed argument goes to this parameter
    [Parameter(Position = 1)]
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
# POSITIONAL PARAMETERS EXPLAINED
# ============================================================================

# POSITION ATTRIBUTE:
# - Position = 0 means first unnamed argument
# - Position = 1 means second unnamed argument
# - Position numbers don't need to be consecutive
# - Named parameters (-Length 25) always work regardless of position

# VERBOSE OUTPUT:
# - [CmdletBinding()] enables the -Verbose switch
# - Write-Verbose only outputs when -Verbose is specified
# - Useful for debugging without cluttering normal output

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

# Using positional parameter (Length = 25) with verbose output:
# .\Figure 5.4.ps1 25 -Verbose
#
# Expected Output:
# VERBOSE: Charset: ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%
# Kj8#mPw2@nQ4pL!5x9YmBn3Qr

# Using both positional parameters:
# .\Figure 5.4.ps1 15 "!@#"
#
# Expected Output: Kj8@mPw2#nQ4pL! (using only !@# as special chars)

# Equivalent named parameter syntax:
# .\Figure 5.4.ps1 -Length 25 -SpecialChars "!@#" -Verbose

