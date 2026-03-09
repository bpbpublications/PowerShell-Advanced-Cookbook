# Figure 2.11 - Member comparison between PSCustomObject and Hashtable
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates the structural differences between PSCustomObject and Hashtable.
# Both can store key-value data, but they behave differently.

# Define sample data
$Name = "Comet"
$Abilities = @("Flying", "LaserEyes")
$Powers = 43

# ============================================================================
# CREATE BOTH OBJECT TYPES
# ============================================================================

# PSCustomObject - ordered, structured object with NoteProperties
$Object1 = [PSCustomObject]@{
    "Abilities" = $Abilities
    "Name"      = $Name
    "Powers"    = $Powers
}

# Hashtable - unordered collection of key-value pairs
$Object2 = @{
    "Abilities" = $Abilities
    "Name"      = $Name
    "Powers"    = $Powers
}

# ============================================================================
# COMPARE MEMBERS
# ============================================================================

Write-Output "=== PSCustomObject Members ==="
$Object1 | Get-Member

# Expected Output (PSCustomObject):
# TypeName: System.Management.Automation.PSCustomObject
#
# Name        MemberType   Definition
# ----        ----------   ----------
# Equals      Method       bool Equals(System.Object obj)
# GetHashCode Method       int GetHashCode()
# GetType     Method       type GetType()
# ToString    Method       string ToString()
# Abilities   NoteProperty Object[] Abilities=System.Object[]
# Name        NoteProperty string Name=Comet
# Powers      NoteProperty int Powers=43

Write-Output ""
Write-Output "=== Hashtable Members ==="
$Object2 | Get-Member

# Expected Output (Hashtable):
# TypeName: System.Collections.Hashtable
#
# Name         MemberType   Definition
# ----         ----------   ----------
# Add          Method       void Add(System.Object key, System.Object value)
# Clear        Method       void Clear()
# Contains     Method       bool Contains(System.Object key)
# ContainsKey  Method       bool ContainsKey(System.Object key)
# ContainsValue Method      bool ContainsValue(System.Object value)
# ... (many more methods)
# Keys         Property     System.Collections.ICollection Keys {get;}
# Values       Property     System.Collections.ICollection Values {get;}
# Count        Property     int Count {get;}

# Key Concepts:
# - PSCustomObject: Properties appear as NoteProperty members
# - Hashtable: Has many built-in methods (Add, Remove, Contains, etc.)
# - PSCustomObject: Better for structured data and pipeline operations
# - Hashtable: Better for dynamic key-value storage and lookups
