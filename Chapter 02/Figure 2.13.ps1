# Figure 2.13 - Hashtable and PSCustomObject data sets output to CSV files
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates the critical difference when exporting to CSV.
# PSCustomObject maintains order; Hashtable does not.

# ============================================================================
# CREATE BOTH DATA STRUCTURES
# ============================================================================

$PSCustomObjectArray = @(
    [PSCustomObject]@{ Name = "Comet"; Abilities = "Flying"; Powers = 43 }
    [PSCustomObject]@{ Name = "Omega"; Abilities = "Flying"; Powers = 34 }
    [PSCustomObject]@{ Name = "Beta";  Abilities = "Flying"; Powers = 50 }
)

$HashtableArray = @(
    @{ Name = "Comet"; Abilities = "Flying"; Powers = 43 }
    @{ Name = "Omega"; Abilities = "Flying"; Powers = 34 }
    @{ Name = "Beta";  Abilities = "Flying"; Powers = 50 }
)

# ============================================================================
# EXPORT TO CSV FILES
# ============================================================================

# Export PSCustomObject array - columns maintain defined order
$PSCustomObjectArray | Export-Csv -Path PSCustomObject.csv -NoTypeInformation

# Export Hashtable array - column order is unpredictable!
$HashtableArray | Export-Csv -Path Hashtable.csv -NoTypeInformation

# ============================================================================
# EXPECTED CSV CONTENTS
# ============================================================================

# PSCustomObject.csv (ordered as defined):
# "Name","Abilities","Powers"
# "Comet","Flying","43"
# "Omega","Flying","34"
# "Beta","Flying","50"

# Hashtable.csv (order varies - could be any arrangement!):
# "Powers","Name","Abilities"
# "43","Comet","Flying"
# "34","Omega","Flying"
# "50","Beta","Flying"

# Verify the exports:
Write-Output "=== PSCustomObject CSV ==="
Get-Content PSCustomObject.csv

Write-Output ""
Write-Output "=== Hashtable CSV ==="
Get-Content Hashtable.csv

# Key Concepts:
# - PSCustomObject preserves property order in CSV export
# - Hashtable order is random/unpredictable in CSV export
# - For data interchange, reporting, or pipelines, use PSCustomObject
# - This is why our Add-Superhero function returns PSCustomObject
