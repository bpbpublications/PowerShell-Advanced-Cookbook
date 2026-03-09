# Figure 5.1 - Password Generator Script with Basic Parameters
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This script demonstrates using CmdletBinding and script parameters
# to create a flexible password generator with customizable options.

[CmdletBinding()]
param (
    # Password length - default is 12 characters
    [int]$Length = 12,

    # Special characters to include - can be customized
    [string]$SpecialChars = "!@#$%",

    # Switch parameters to exclude character types
    # Switches default to $false when not specified
    [switch]$ExcludeUpperCase,
    [switch]$ExcludeLowerCase,
    [switch]$ExcludeDigits,
    [switch]$ExcludeSpecialChars
)

# ============================================================================
# BUILD CHARACTER SET
# ============================================================================

# Start with empty string and add character groups based on switches
$charSet = ""

# Add uppercase letters unless excluded
if (-not $ExcludeUpperCase) {
    $charSet += "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
}

# Add lowercase letters unless excluded
if (-not $ExcludeLowerCase) {
    $charSet += "abcdefghijklmnopqrstuvwxyz"
}

# Add digits unless excluded
if (-not $ExcludeDigits) {
    $charSet += "0123456789"
}

# Add special characters unless excluded
if (-not $ExcludeSpecialChars) {
    $charSet += $SpecialChars
}

# ============================================================================
# GENERATE PASSWORD
# ============================================================================

# Write-Verbose only outputs when -Verbose is specified
Write-Verbose "Charset: $CharSet"

# Get-Random selects $Length random characters from the charset
# -join combines them into a single string
$password = -join (Get-Random -Count $Length -InputObject $charSet.ToCharArray())
$password

# ============================================================================
# KEY CONCEPTS
# ============================================================================

# [CmdletBinding()] enables:
# - -Verbose parameter for debugging output
# - -Debug parameter for debug messages
# - -ErrorAction, -WarningAction common parameters
# - Support for Write-Verbose, Write-Debug cmdlets

# SWITCH PARAMETERS:
# - Default to $false when not specified
# - Become $true when specified (no value needed)
# - Test with: if ($SwitchName) or if (-not $SwitchName)

# PARAMETER DEFAULTS:
# - Specified with = after parameter declaration
# - Used when caller doesn't provide a value

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

# Generate default 12-character password:
# .\Figure 5.1.ps1

# Generate 20-character password:
# .\Figure 5.1.ps1 -Length 20

# Exclude uppercase for lowercase+digits+special:
# .\Figure 5.1.ps1 -ExcludeUpperCase

# See the charset being used:
# .\Figure 5.1.ps1 -Verbose

# Custom special characters:
# .\Figure 5.1.ps1 -SpecialChars "@#$"

# Expected Output:
# Kj8#mPw2@nQ4 (random password)
#
# With -Verbose:
# VERBOSE: Charset: ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%
# Kj8#mPw2@nQ4
