# Recipe: String Formatting in PowerShell
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates various ways to format strings in PowerShell,
# including interpolation, format operators, and here-strings.

# ============================================================================
# STRING INTERPOLATION
# ============================================================================

# Basic string interpolation with variables
$Hero = "Comet"
$Villain = "Evilin"

$Text = "The hero is: $Hero and the villain is: $Villain"
# Output: The hero is: Comet and the villain is: Evilin

# Interpolation with different data types
# PowerShell automatically converts to string
$String = "Superhero"
$Integer = 25
$Bool = $true

$Text = "This is a string: $String This is an integer: $Integer and this is a bool: $Bool"
# Output: This is a string: Superhero This is an integer: 25 and this is a bool: True

# ============================================================================
# FORMAT OPERATOR (-f)
# ============================================================================

# Basic format operator usage
$Hero = "Comet"
$Villain = "Evilin"

$Text = "The hero is: {0} and the villain is: {1}" -f $Hero, $Villain
# Output: The hero is: Comet and the villain is: Evilin

# Number format specifier (N) - adds thousand separators and decimals
[double]$Float = 3.16543

$Text = "The villain has {0:N2}% chance of beating this hero" -f $Float
# Output: The villain has 3.17% chance of beating this hero

# Custom date format specifier
$Date = Get-Date

$Text = "A new superhero is born the {0:dd-MM-yyyy} at {1:HH:mm:ss}" -f $Date, $Date
# Output: A new superhero is born the 08-08-2023 at 14:47:06

# ============================================================================
# SUBEXPRESSION OPERATOR $()
# ============================================================================

# Evaluate expression inside string
$Hero = [PSCustomObject]@{
    Strength = 55
    Level = 7
}
$Text = "The hero's total power is: $($Hero.Strength * $Hero.Level)"
# Output: The hero's total power is: 385

# Execute function inside string
function New-Date {
    return Get-Date -Format "dd-MM-yyyy HH:mm:ss"
}

$Text = "A new hero is born: $(New-Date)"
# Output: A new hero is born: 09-08-2023 09:25:30

# Execute command inside string
$Text = "StatusCode: $( (Invoke-WebRequest google.com).StatusCode )"
# Output: StatusCode: 200

# ============================================================================
# ESCAPE SEQUENCES
# ============================================================================

# Backtick escapes quotes inside double-quoted strings
$Text = "Backticks can be used to escape `"quotes`" inside strings"
# Output: Backticks can be used to escape "quotes" inside strings

# Common escape sequences
$Text = "`"And in escape sequences like newlines`nand tabs`twhich is cool`""
# Output:
# "And in escape sequences like newlines
# and tabs        which is cool"

# ESCAPE SEQUENCES:
# `n  - Newline
# `t  - Tab
# `r  - Carriage return
# ``  - Literal backtick
# `"  - Double quote
# `'  - Single quote (in double-quoted strings)
# `0  - Null character

# ============================================================================
# HERE-STRINGS
# ============================================================================

# Double-quoted here-string (allows interpolation)
$Hero = "Comet"

$Text = @"
Double quoted Here-strings are perfect for creating multiline strings.
You can interpolate variables: $Hero
use subexpressions: $(Get-Date)
and even use the format {0}.
"@ -f "operator"

# Output:
# Double quoted Here-strings are perfect for creating multiline strings.
# You can interpolate variables: Comet
# use subexpressions: 08/09/2023 10:02:39
# and even use the format operator.

# Single-quoted here-string (literal, no interpolation)
$Hero = "Comet"

$Text = @'
Single quoted Here-strings are perfect for creating multiline strings.
But you cannot interpolate variables: $Hero
or use subexpressions: $(Get-Date)
But you can still use the format {0}.
'@ -f "operator"

# Output:
# Single quoted Here-strings are perfect for creating multiline strings.
# But you cannot interpolate variables: $Hero
# or use subexpressions: $(Get-Date)
# But you can still use the format operator.

# ============================================================================
# KEY DIFFERENCES
# ============================================================================

# DOUBLE QUOTES (""):
# - Variables are expanded: "$Hero" -> "Comet"
# - Subexpressions work: "$(1+1)" -> "2"
# - Escape sequences work: "`n" -> newline

# SINGLE QUOTES (''):
# - Variables are NOT expanded: '$Hero' -> "$Hero"
# - Subexpressions NOT evaluated: '$(1+1)' -> "$(1+1)"
# - Escape sequences NOT processed: '`n' -> "`n"

