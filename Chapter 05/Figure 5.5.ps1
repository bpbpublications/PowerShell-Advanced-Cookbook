# Figure 5.5 - Password Generator with Pipeline Integration
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates piping script output to other cmdlets.
# The password generator output can be converted to SecureString.

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
# PIPELINE INTEGRATION
# ============================================================================

# Scripts can be piped like any cmdlet. The output goes to the pipeline
# and can be consumed by downstream cmdlets.

# SECURESTRING CONVERSION:
# - ConvertTo-SecureString encrypts a plain text string
# - -AsPlainText indicates the input is not already encrypted
# - -Force suppresses the warning about using plain text
# - SecureString protects credentials in memory

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

# Generate password and convert to SecureString:
# $SecurePassword = .\Figure 5.5.ps1 25 | ConvertTo-SecureString -AsPlainText -Force
# $SecurePassword
#
# Expected Output:
# System.Security.SecureString

# Create a PSCredential object for authentication:
# $Username = "admin@domain.com"
# $SecurePassword = .\Figure 5.5.ps1 25 | ConvertTo-SecureString -AsPlainText -Force
# $Credential = New-Object System.Management.Automation.PSCredential($Username, $SecurePassword)

# Use the credential for remote operations:
# Connect-AzAccount -Credential $Credential
# Invoke-Command -ComputerName Server01 -Credential $Credential -ScriptBlock { hostname }

# Save encrypted password to file (Windows only - uses DPAPI):
# $SecurePassword | ConvertFrom-SecureString | Out-File "password.txt"
# $Restored = Get-Content "password.txt" | ConvertTo-SecureString

