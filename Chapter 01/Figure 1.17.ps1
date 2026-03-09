# Figure 1.17 - Remove Registry Keys and Registry Key Properties
# Chapter 1: Introduction to Advanced PowerShell Concepts
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows only

# This script demonstrates how to safely remove registry keys and their
# properties using Remove-Item and Remove-ItemProperty.

# WARNING: Removing registry keys can affect system and application behavior.
# Always verify you're removing the correct items. Use -WhatIf to preview changes.

# ============================================================================
# SETUP: Create test registry keys (will be removed in this demo)
# ============================================================================

Write-Output "=== SETUP: Creating test registry structure ==="

# Create the test structure
New-Item -Path "HKCU:\Software\TestKey" -Force | Out-Null
New-Item -Path "HKCU:\Software\TestKey\SubTestKey" -Force | Out-Null

# Set properties for TestKey
Set-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value1" -Value "TestValue1"
Set-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value2" -Value "TestValue2"
Set-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value3" -Value "TestValue3"

# Set properties for SubTestKey
Set-ItemProperty -Path "HKCU:\Software\TestKey\SubTestKey" -Name "SubValue1" -Value "SubTestValue1"
Set-ItemProperty -Path "HKCU:\Software\TestKey\SubTestKey" -Name "SubValue2" -Value "SubTestValue2"
Set-ItemProperty -Path "HKCU:\Software\TestKey\SubTestKey" -Name "SubValue3" -Value "SubTestValue3"

Write-Output "Test structure created:"
Get-Item -Path "HKCU:\Software\TestKey"
Get-Item -Path "HKCU:\Software\TestKey\SubTestKey"

# ============================================================================
# DEMONSTRATION: Using -WhatIf for safe preview
# ============================================================================

Write-Output ""
Write-Output "=== Using -WhatIf to preview removal (no actual changes) ==="

# Always preview destructive operations with -WhatIf first
Remove-Item -Path "HKCU:\Software\TestKey\SubTestKey" -WhatIf

# Expected Output:
# What if: Performing the operation "Remove Key" on target "Item: HKEY_CURRENT_USER\Software\TestKey\SubTestKey".

# ============================================================================
# DEMONSTRATION: Removing a registry key (subkey)
# ============================================================================

Write-Output ""
Write-Output "=== Removing SubTestKey ==="

# Remove the subkey entirely
Remove-Item -Path "HKCU:\Software\TestKey\SubTestKey"

# Verify it's gone - this will produce an error (expected)
Write-Output "Attempting to access removed key (should fail):"
if (Test-Path "HKCU:\Software\TestKey\SubTestKey") {
    Get-Item -Path "HKCU:\Software\TestKey\SubTestKey"
} else {
    Write-Output "SubTestKey has been successfully removed."
}

# ============================================================================
# DEMONSTRATION: Removing a specific property (value)
# ============================================================================

Write-Output ""
Write-Output "=== Before removing Value1 property ==="
Get-Item -Path "HKCU:\Software\TestKey"

Write-Output ""
Write-Output "=== Removing Value1 property from TestKey ==="

# Remove-ItemProperty removes a specific property (value), not the key itself
Remove-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value1"

Write-Output ""
Write-Output "=== After removing Value1 property ==="
Get-Item -Path "HKCU:\Software\TestKey"

# Expected Output:
# Value1 is no longer listed in the properties
# Value2 and Value3 remain

# ============================================================================
# DEMONSTRATION: Removing a key with children
# ============================================================================

Write-Output ""
Write-Output "=== Recreating SubTestKey for recursive removal demo ==="
New-Item -Path "HKCU:\Software\TestKey\SubTestKey" -Force | Out-Null

Write-Output ""
Write-Output "=== Removing TestKey and all its children recursively ==="

# Use -Recurse to remove a key and all its subkeys
Remove-Item -Path "HKCU:\Software\TestKey" -Recurse

# Verify complete removal
if (Test-Path "HKCU:\Software\TestKey") {
    Write-Output "TestKey still exists."
} else {
    Write-Output "TestKey and all subkeys have been successfully removed."
}

# ============================================================================
# Summary of Remove commands for Registry
# ============================================================================
# Remove-Item -Path <key>              : Remove a key (fails if has children)
# Remove-Item -Path <key> -Recurse     : Remove a key and all children
# Remove-ItemProperty -Path <key> -Name <property> : Remove a specific property/value
#
# Safety tips:
# - Always use -WhatIf first to preview changes
# - Use -Confirm to require confirmation before each removal
# - Consider backing up keys with reg export before removal
