# Figure 1.15 - Use Get-Item to return Registry Keys and their Properties
# Chapter 1: Introduction to Advanced PowerShell Concepts
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows only

# This script demonstrates creating registry keys and properties, then
# retrieving them using Get-Item. This is useful for storing application
# settings in a central, accessible location.

# WARNING: This script modifies the Windows Registry. While it only creates
# test keys in HKCU:\Software (which is safe), always be careful with registry
# modifications in production environments.

# ============================================================================
# SETUP: Create test registry keys and properties for demonstration
# ============================================================================

# Create a new registry key under HKCU:\Software
# New-Item creates keys (like mkdir creates directories)
New-Item -Path "HKCU:\Software\TestKey" -Force

# Expected Output:
#     Hive: HKEY_CURRENT_USER\Software
# Name                           Property
# ----                           --------
# TestKey

# Create a subkey under our new TestKey
New-Item -Path "HKCU:\Software\TestKey\SubTestKey" -Force

# Set properties (values) for TestKey
# Set-ItemProperty creates or updates registry values
# Unlike filesystem files, registry keys can have multiple named values
Set-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value1" -Value "TestValue1"
Set-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value2" -Value "TestValue2"
Set-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value3" -Value "TestValue3"

# Set properties for SubTestKey
Set-ItemProperty -Path "HKCU:\Software\TestKey\SubTestKey" -Name "SubValue1" -Value "SubTestValue1"
Set-ItemProperty -Path "HKCU:\Software\TestKey\SubTestKey" -Name "SubValue2" -Value "SubTestValue2"
Set-ItemProperty -Path "HKCU:\Software\TestKey\SubTestKey" -Name "SubValue3" -Value "SubTestValue3"

Write-Output "Registry keys and properties created successfully."
Write-Output ""

# ============================================================================
# DEMONSTRATION: Using Get-Item to retrieve registry keys
# ============================================================================

# Get-Item returns the KEY itself (not its children)
# This shows the key and all its properties/values
Write-Output "=== Get-Item on TestKey ==="
Get-Item HKCU:\SOFTWARE\TestKey

# Expected Output:
#     Hive: HKEY_CURRENT_USER\SOFTWARE
#
# Name                           Property
# ----                           --------
# TestKey                        Value1 : TestValue1
#                                Value2 : TestValue2
#                                Value3 : TestValue3

Write-Output ""
Write-Output "=== Get-Item on SubTestKey ==="
Get-Item HKCU:\SOFTWARE\TestKey\SubTestKey

# Expected Output:
#     Hive: HKEY_CURRENT_USER\SOFTWARE\TestKey
#
# Name                           Property
# ----                           --------
# SubTestKey                     SubValue1 : SubTestValue1
#                                SubValue2 : SubTestValue2
#                                SubValue3 : SubTestValue3

# Compare with Get-ChildItem which lists child keys (not properties)
Write-Output ""
Write-Output "=== Get-ChildItem on TestKey (shows subkeys, not properties) ==="
Get-ChildItem HKCU:\SOFTWARE\TestKey

# ============================================================================
# CLEANUP: Remove the test registry keys (uncomment to run)
# ============================================================================
# Remove the parent key recursively (removes all subkeys and values)
# Remove-Item -Path "HKCU:\Software\TestKey" -Recurse -Force
# Write-Output "Cleanup complete: TestKey and all subkeys removed."
