# Figure 2.23 - WhatIf and Confirm parameters for safe operations
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates the built-in -WhatIf and -Confirm parameters that
# PowerShell provides for cmdlets that support ShouldProcess.

# ============================================================================
# USING -WHATIF TO PREVIEW DANGEROUS OPERATIONS
# ============================================================================

Write-Output "=== Using -WhatIf to Preview Operations ==="

# -WhatIf shows what WOULD happen without actually doing it
# This is essential for testing destructive commands safely

# Preview what files would be deleted
Get-ChildItem | Remove-Item -WhatIf

# Expected Output:
# What if: Performing the operation "Remove File" on target "C:\path\to\file1.txt".
# What if: Performing the operation "Remove File" on target "C:\path\to\file2.ps1".
# ... (one line per file)

# The files are NOT actually deleted - just showing what would happen

# ============================================================================
# USING -CONFIRM TO REQUIRE APPROVAL
# ============================================================================

Write-Output ""
Write-Output "=== Using -Confirm to Require Approval ==="

# -Confirm prompts for each operation
# User must type Y (yes), N (no), A (yes to all), or L (no to all)

# Note: This line is commented out as it requires interactive input
# Get-ChildItem | Remove-Item -Confirm

# When run interactively:
# Confirm
# Are you sure you want to perform this action?
# Performing the operation "Remove File" on target "C:\path\to\file.txt".
# [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):

# ============================================================================
# COMBINING -WHATIF AND -CONFIRM
# ============================================================================

Write-Output ""
Write-Output "=== Combining Both Parameters ==="

# You can use both together for extra safety during testing
# -WhatIf takes precedence - no actual changes occur
Get-ChildItem | Remove-Item -WhatIf -Confirm

# Output shows WhatIf messages but doesn't prompt (WhatIf overrides)

# ============================================================================
# PRACTICAL EXAMPLE: SAFE FILE CLEANUP
# ============================================================================

Write-Output ""
Write-Output "=== Practical Example: Safe Cleanup ==="

# Step 1: First see what would be affected (always preview first!)
Write-Output "Files that would be removed:"
Get-ChildItem -Path $env:TEMP -Filter "*.tmp" -ErrorAction SilentlyContinue |
    Remove-Item -WhatIf

# Step 2: If the preview looks correct, run without -WhatIf
# Get-ChildItem -Path $env:TEMP -Filter "*.tmp" | Remove-Item

# Key Concepts:
# - -WhatIf: Shows what would happen without executing (dry run)
# - -Confirm: Prompts for confirmation before each action
# - These are AUTOMATIC in functions with [CmdletBinding(SupportsShouldProcess)]
# - -WhatIf takes precedence over -Confirm
# - Always use -WhatIf first when testing destructive operations
# - Use -Confirm for production scripts that modify important data
# - See Figure 2.24 for implementing ShouldProcess in your own functions
