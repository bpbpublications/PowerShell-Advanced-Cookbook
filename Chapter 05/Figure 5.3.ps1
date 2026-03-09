# Figure 5.3 - Password Generator with Mandatory Parameter
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This enhances Figure 5.2 by making the Length parameter mandatory.
# Mandatory parameters must be supplied by the caller - no default value.

[CmdletBinding()]
param (
    # Mandatory = $true means the user MUST provide this value
    # Position = 0 allows passing the value without naming the parameter
    # Without a default value, PowerShell prompts if not provided
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateRange(8, 63)]
    [int]$Length,

    # Position = 1 allows: .\Script.ps1 20 "!@#"
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
# MANDATORY PARAMETER BEHAVIOR
# ============================================================================

# When a mandatory parameter is missing, PowerShell prompts interactively:
#
# cmdlet Figure 5.3.ps1 at command pipeline position 1
# Supply values for the following parameters:
# Length: _
#
# This behavior ensures critical parameters are never forgotten.
# In non-interactive contexts (scheduled tasks), missing mandatory
# parameters cause the script to fail with an error.

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

# Invoked without any arguments (will prompt for Length):
# .\Figure 5.3.ps1
# Length: 16
#
# Expected Output: Kj8#mPw2@nQ4pL!5 (random 16-char password)

# Invoked with positional parameter:
# .\Figure 5.3.ps1 20
#
# Expected Output: Kj8#mPw2@nQ4pL!5x9Ym (random 20-char password)

