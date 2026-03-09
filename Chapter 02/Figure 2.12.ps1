# Figure 2.12 - Arrays with PSCustomObject and Hashtable data types
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates how arrays of PSCustomObject vs Hashtable display differently.
# The structure affects readability and usability.

# ============================================================================
# CREATE ARRAY OF PSCUSTOMOBJECTS
# ============================================================================

$PSCustomObjectArray = @(
    [PSCustomObject]@{ Name = "Comet"; Abilities = "Flying"; Powers = 43 }
    [PSCustomObject]@{ Name = "Omega"; Abilities = "Flying"; Powers = 34 }
    [PSCustomObject]@{ Name = "Beta";  Abilities = "Flying"; Powers = 50 }
)

Write-Output "=== PSCustomObject Array ==="
$PSCustomObjectArray

# Expected Output (ordered, tabular format):
# Name  Abilities Powers
# ----  --------- ------
# Comet Flying        43
# Omega Flying        34
# Beta  Flying        50

# ============================================================================
# CREATE ARRAY OF HASHTABLES
# ============================================================================

$HashtableArray = @(
    @{ Name = "Comet"; Abilities = "Flying"; Powers = 43 }
    @{ Name = "Omega"; Abilities = "Flying"; Powers = 34 }
    @{ Name = "Beta";  Abilities = "Flying"; Powers = 50 }
)

Write-Output ""
Write-Output "=== Hashtable Array ==="
$HashtableArray

# Expected Output (unordered key-value format):
# Name                           Value
# ----                           -----
# Powers                         43
# Abilities                      Flying
# Name                           Comet
# Powers                         34
# Abilities                      Flying
# Name                           Omega
# ... (order varies each time!)

# Key Concepts:
# - PSCustomObject: Clean tabular output with column headers
# - Hashtable: Key-value pairs, harder to read as a table
# - PSCustomObject: Property order is preserved
# - Hashtable: Order is unpredictable
# - For displaying or exporting data, PSCustomObject is superior
