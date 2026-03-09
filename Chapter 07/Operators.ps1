# Recipe: Pester Assertion Operators Reference
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Comprehensive reference for Pester Should assertion operators.

# ============================================================================
# -Be - EQUALITY (CASE INSENSITIVE)
# ============================================================================

# Checks if values are equal (case-insensitive for strings)
"STRING" | Should -Be "String"     # Pass - case insensitive
"STRING" | Should -Be "string"     # Pass - case insensitive
42 | Should -Be 42                 # Pass - numeric equality

# ============================================================================
# -BeExactly - EQUALITY (CASE SENSITIVE)
# ============================================================================

# Checks if values are exactly equal (case-sensitive for strings)
"STRING" | Should -BeExactly "String"  # Fail - case sensitive
"STRING" | Should -BeExactly "STRING"  # Pass - exact match

# ============================================================================
# -Exist - FILE/DIRECTORY EXISTS
# ============================================================================

# Checks if a file or directory exists at the specified path
"C:\Temp\TestFile.txt" | Should -Exist      # Pass if file exists
"C:\Temp\TestFile.txt" | Should -Not -Exist # Pass if file does NOT exist

# ============================================================================
# -Contain - COLLECTION/STRING CONTAINS (CASE INSENSITIVE)
# ============================================================================

# Checks if a collection, file, or string contains a value
"String" | Should -Contain "s"                      # Pass - substring
"String" | Should -Contain "T"                      # Fail - 'T' not in string
"Blue", "Green", "Red" | Should -Contain "blue"     # Pass - case insensitive
"Blue", "Green", "Red" | Should -Contain "Yellow"   # Fail - not in array

# For files - checks if file contains the text
"C:\Temp\TestFile.txt" | Should -Contain "Word"     # Pass if file contains "Word"

# ============================================================================
# -ContainExactly - COLLECTION/STRING CONTAINS (CASE SENSITIVE)
# ============================================================================

# Checks if collection/string contains value (case-sensitive)
"String" | Should -ContainExactly "s"              # Fail - 's' not 'S'
"String" | Should -ContainExactly "S"              # Pass - exact match
"Blue", "Green", "Red" | Should -ContainExactly "blue"  # Fail - case matters
"Blue", "Green", "Red" | Should -ContainExactly "Red"   # Pass - exact match

# ============================================================================
# -Match - REGEX PATTERN (CASE INSENSITIVE)
# ============================================================================

# Uses regular expression for comparison (case-insensitive)
"This is True" | Should -Match "This is"           # Pass - pattern found
"This is True" | Should -Match "This is not true"  # Fail - pattern not found
"Error: 404" | Should -Match "\d+"                 # Pass - matches digits

# ============================================================================
# -MatchExactly - REGEX PATTERN (CASE SENSITIVE)
# ============================================================================

# Uses regular expression for comparison (case-sensitive)
"This is True" | Should -MatchExactly "This is"    # Pass - pattern found
"This is True" | Should -MatchExactly "This Is"    # Fail - case matters

# ============================================================================
# -Throw - EXCEPTION HANDLING
# ============================================================================

# Checks if an expression throws an exception
# IMPORTANT: Input must be in a scriptblock { }
{ String } | Should -Throw                    # Pass - undefined command throws
{ String } | Should -Not -Throw               # Fail - it does throw
{ $Var = "String" } | Should -Throw           # Fail - assignment doesn't throw
{ $Var = "String" } | Should -Not -Throw      # Pass - no exception
{ throw "Error" } | Should -Throw "Error"     # Pass - specific error message
{ throw "Error" } | Should -Not -Throw "Error" # Fail - it throws "Error"

# ============================================================================
# -BeNullOrEmpty - NULL OR EMPTY CHECK
# ============================================================================

# Checks if value is null, empty string, or empty collection
$null | Should -BeNullOrEmpty           # Pass - null
$null | Should -Not -BeNullOrEmpty      # Fail - is null
"" | Should -BeNullOrEmpty              # Pass - empty string
"String" | Should -BeNullOrEmpty        # Fail - has value
@() | Should -BeNullOrEmpty             # Pass - empty array

# ============================================================================
# ADDITIONAL USEFUL OPERATORS
# ============================================================================

# -BeGreaterThan / -BeLessThan - Numeric comparison
# 10 | Should -BeGreaterThan 5           # Pass
# 5 | Should -BeLessThan 10              # Pass

# -BeOfType - Type checking
# "String" | Should -BeOfType [string]   # Pass
# 42 | Should -BeOfType [int]            # Pass

# -HaveCount - Collection count
# @(1,2,3) | Should -HaveCount 3         # Pass
