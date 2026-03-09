# Figure 1.16 - Using Get-ItemProperty to Get Registry Key Property Values
# Chapter 1: Introduction to Advanced PowerShell Concepts
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows only

# This script demonstrates how to retrieve specific property values from
# registry keys using Get-ItemProperty and access individual values.

# NOTE: This script requires the test keys from Figure 1.15.
# Run Figure 1.15 first to create the necessary registry structure.

# ============================================================================
# SETUP: Create test registry keys (same as Figure 1.15)
# ============================================================================

# Create keys and properties if they don't exist
if (-not (Test-Path "HKCU:\Software\TestKey")) {
    New-Item -Path "HKCU:\Software\TestKey" -Force | Out-Null
    New-Item -Path "HKCU:\Software\TestKey\SubTestKey" -Force | Out-Null
    Set-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value1" -Value "TestValue1"
    Set-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value2" -Value "TestValue2"
    Set-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value3" -Value "TestValue3"
    Set-ItemProperty -Path "HKCU:\Software\TestKey\SubTestKey" -Name "SubValue1" -Value "SubTestValue1"
    Write-Output "Test registry keys created."
}

# ============================================================================
# DEMONSTRATION: Using Get-ItemProperty
# ============================================================================

Write-Output "=== Get-ItemProperty for a specific property ==="

# Get a specific property by name
# This returns the value along with PSPath metadata
Get-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value1"

# Expected Output:
# Value1       : TestValue1
# PSPath       : Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software\TestKey
# PSParentPath : Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software
# PSChildName  : TestKey
# PSDrive      : HKCU
# PSProvider   : Microsoft.PowerShell.Core\Registry

Write-Output ""
Write-Output "=== Accessing just the value using dot notation ==="

# To get just the value (not the metadata), save to a variable and use dot notation
$Value1 = Get-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value1"
$Value1.Value1

# Expected Output:
# TestValue1

Write-Output ""
Write-Output "=== Alternative: Direct property access ==="

# You can also access the value directly in one line
(Get-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value1").Value1

# Or get all properties and select specific ones
$allProps = Get-ItemProperty -Path "HKCU:\Software\TestKey"
Write-Output "Value1: $($allProps.Value1)"
Write-Output "Value2: $($allProps.Value2)"
Write-Output "Value3: $($allProps.Value3)"

Write-Output ""
Write-Output "=== Get all properties of a key ==="

# Without -Name parameter, Get-ItemProperty returns ALL properties
Get-ItemProperty -Path "HKCU:\Software\TestKey"

# Expected Output includes all three values plus PS* metadata properties

Write-Output ""
Write-Output "=== Selecting only specific properties (excluding metadata) ==="

# Use Select-Object to filter out the PS* metadata properties
Get-ItemProperty -Path "HKCU:\Software\TestKey" |
    Select-Object -Property Value1, Value2, Value3

# Expected Output:
# Value1      Value2      Value3
# ------      ------      ------
# TestValue1  TestValue2  TestValue3

# ============================================================================
# CLEANUP: Remove the test registry keys (uncomment to run)
# ============================================================================
# Remove-Item -Path "HKCU:\Software\TestKey" -Recurse -Force
# Write-Output "Cleanup complete: TestKey and all subkeys removed."
