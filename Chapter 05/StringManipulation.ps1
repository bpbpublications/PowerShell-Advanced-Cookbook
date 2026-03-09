# Recipe: String Manipulation in PowerShell
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates common string manipulation operations including
# concatenation, replacement, extraction, splitting, joining, and case conversion.

# ============================================================================
# STRING CONCATENATION
# ============================================================================

# Using the + operator to concatenate strings
$First = "Lightning"
$Last = "Girl"
$Name = $First + " " + $Last
# Output: Lightning Girl

# ============================================================================
# SEARCH AND REPLACE
# ============================================================================

# String method: Replace() - case-sensitive, literal match
$Text = "These superheroes are Villains: Comet, Lightning Girl"
$Text = $Text.Replace("Villains", "Heroes")
# Output: These superheroes are Heroes: Comet, Lightning Girl

# Operator: -replace - case-insensitive by default, supports regex
$Text = "These superheroes are Villains: Comet, Lightning Girl"
$Text = $Text -replace "Villains", "Heroes"
# Output: These superheroes are Heroes: Comet, Lightning Girl

# Operator: -ireplace - explicitly case-insensitive
$Text = "These superheroes are Villains: Comet, Lightning Girl"
$Text = $Text -ireplace "villains", "heroes"
# Output: These superheroes are heroes: Comet, Lightning Girl

# Operator with RegEx pattern
$Text = "Comet has 47 HitPoints, Lightning Girl has 25 HitPoints"
$Text = $Text -replace "\d+", "50"
# Output: Comet has 50 HitPoints, Lightning Girl has 50 HitPoints

# ============================================================================
# SUBSTRING EXTRACTION
# ============================================================================

# Substring with two arguments (startIndex, length)
$Text = "Lightning Girl meets Comet"
$Substring = $Text.Substring(10, 4)
# Output: Girl

# Substring with one argument (startIndex to end)
$Text = "Lightning Girl meets Comet"
$Substring = $Text.Substring(10)
# Output: Girl meets Comet

# ============================================================================
# REGEX PATTERN MATCHING
# ============================================================================

# Extract email addresses using regex
$Text = "My personal email is email@home.com and my work email is email@work.com"
$Emails = [regex]::Matches($Text, "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}") |
    ForEach-Object { $_.Value }
# Output: email@home.com, email@work.com

# Extract IP addresses using regex
$Text = "Server 1: 192.168.1.100, Server 2: 10.0.0.2, Gateway: 172.16.0.1"
$IPAddresses = [regex]::Matches($Text, "\b(?:\d{1,3}\.){3}\d{1,3}\b") |
    ForEach-Object { $_.Value }
# Output: 192.168.1.100, 10.0.0.2, 172.16.0.1

# Extract MAC addresses using regex
$Text = "Device 1: AA:BB:CC:DD:EE:FF, Device 2: 11:22:33:44:55:66"
$MACAddresses = [regex]::Matches($Text, "([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})") |
    ForEach-Object { $_.Value }
# Output: AA:BB:CC:DD:EE:FF, 11:22:33:44:55:66

# ============================================================================
# SPLITTING STRINGS
# ============================================================================

# Split() method with delimiter
$Text = "Comet;Lightning Girl;Blue Ghost;Evilin"
$Array = $Text.Split(";")
# Output: Comet, Lightning Girl, Blue Ghost, Evilin (as array)

# -split operator (supports regex)
$Text = "Comet;Lightning Girl;Blue Ghost;Evilin"
$Array = $Text -split ";"
# Output: Comet, Lightning Girl, Blue Ghost, Evilin (as array)

# -split with regex pattern (multiple delimiters)
$Text = "Comet;Lightning Girl,Blue Ghost#Evilin"
$Array = $Text -split "[;,#]"
# Output: Comet, Lightning Girl, Blue Ghost, Evilin (as array)

# ============================================================================
# JOINING ARRAYS
# ============================================================================

# -join operator with delimiter
$Array = @("Comet", "Lightning Girl", "Blue Ghost", "Evilin")
$Text = $Array -join ";"
# Output: Comet;Lightning Girl;Blue Ghost;Evilin

# -join with empty string (concatenate)
$Array = @("Comet", "Lightning Girl", "Blue Ghost", "Evilin")
$Text = $Array -join ""
# Output: CometLightning GirlBlue GhostEvilin

# ============================================================================
# TRIMMING WHITESPACE
# ============================================================================

# Trim() - removes whitespace from both ends
$Text = "     Villains vs. Heroes      "
$Text = $Text.Trim()
# Output: Villains vs. Heroes

# Trim specific character
$Text = "***     Villains vs. Heroes      ***"
$Text = $Text.Trim("*")
# Output:      Villains vs. Heroes

# Trim multiple characters using char array
$Text = "***     Villains vs. Heroes      ***"
$Text = $Text.Trim([char[]]"* ")
# Output: Villains vs. Heroes

# TrimStart() and TrimEnd() for one-sided trimming
# $Text.TrimStart()  # Left side only
# $Text.TrimEnd()    # Right side only

# ============================================================================
# CASE CONVERSION
# ============================================================================

# Convert to UPPERCASE
$Text = "Comet is a Hero"
$Text = $Text.ToUpper()
# Output: COMET IS A HERO

# Convert to lowercase
$Text = "COMET is a Hero"
$Text = $Text.ToLower()
# Output: comet is a hero

# ============================================================================
# PADDING
# ============================================================================

# PadLeft - add padding to left (right-align text)
$Text = "Lightning Girl"
$Text = $Text.PadLeft(20)
# Output: "      Lightning Girl"

# PadRight - add padding to right (left-align text)
$Text = "Lightning Girl"
$Text = $Text.PadRight(20)
# Output: "Lightning Girl      "

# Custom padding character
$Text = "Lightning Girl"
$Text = $Text.PadRight(20, "*")
# Output: "Lightning Girl******"

# Center text with equal padding on both sides
$Text = "Lightning Girl"
$Padding = 20
$Text = $Text.PadLeft($Padding, "*").PadRight($Padding + ($Padding - $Text.Length), "*")
# Output: "***Lightning Girl***"

