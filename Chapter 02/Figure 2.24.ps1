# Figure 2.24 - Implementing ShouldProcess in custom functions
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates how to add -WhatIf and -Confirm support to your own functions
# using SupportsShouldProcess and $PSCmdlet.ShouldProcess().

function Remove-File {
    # SupportsShouldProcess enables -WhatIf and -Confirm parameters automatically
    # ConfirmImpact determines when -Confirm is auto-triggered:
    #   - "Low"    : Never auto-prompts
    #   - "Medium" : Prompts when $ConfirmPreference is Medium or lower (default)
    #   - "High"   : Prompts when $ConfirmPreference is High or lower
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$File
    )

    # ========================================================================
    # THREE OVERLOADS OF SHOULDPROCESS
    # ========================================================================

    # Overload 1: ShouldProcess("Target")
    # Shows: "Performing the operation 'Remove-File' on target 'filename'"
    Write-Output "--- Testing Overload 1: ShouldProcess(Target) ---"
    if ($PSCmdlet.ShouldProcess($File)) {
        Write-Output "Would execute: Remove-Item -Path $File"
        # Remove-Item -Path $File  # Uncomment to actually remove
    }

    # Overload 2: ShouldProcess("Target", "Action")
    # Shows: "Performing the operation 'Remove' on target 'filename'"
    Write-Output ""
    Write-Output "--- Testing Overload 2: ShouldProcess(Target, Action) ---"
    if ($PSCmdlet.ShouldProcess($File, "Remove")) {
        Write-Output "Would execute: Remove-Item -Path $File"
        # Remove-Item -Path $File  # Uncomment to actually remove
    }

    # Overload 3: ShouldProcess("Message", "Target", "Action")
    # Shows: "Action: Target" with custom message
    # Most flexible - you control all displayed text
    Write-Output ""
    Write-Output "--- Testing Overload 3: ShouldProcess(Message, Target, Action) ---"
    if ($PSCmdlet.ShouldProcess("Permanently deleting file", $File, "Remove")) {
        Write-Output "Would execute: Remove-Item -Path $File"
        # Remove-Item -Path $File  # Uncomment to actually remove
    }
}

# ============================================================================
# EXAMPLE: USING -WHATIF
# ============================================================================

Write-Output "=== Testing Remove-File with -WhatIf ==="
Write-Output ""

# Create a test file to demonstrate (won't be deleted due to -WhatIf)
$TestFile = ".\TestFile.txt"
"Test content" | Out-File -FilePath $TestFile

# Call with -WhatIf to preview
Remove-File -File $TestFile -WhatIf

# Expected Output:
# What if: Performing the operation "Remove-File" on target ".\TestFile.txt".
# What if: Performing the operation "Remove" on target ".\TestFile.txt".
# What if: Performing the operation "Remove" on target ".\TestFile.txt".

# ============================================================================
# EXAMPLE: USING -CONFIRM
# ============================================================================

Write-Output ""
Write-Output "=== Testing Remove-File with -Confirm ==="

# Note: This would prompt interactively, so it's commented out for non-interactive runs
# Remove-File -File $TestFile -Confirm

# Interactive prompt would show:
# Confirm
# Are you sure you want to perform this action?
# Performing the operation "Remove-File" on target ".\TestFile.txt".
# [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help

# ============================================================================
# CLEANUP
# ============================================================================

# Remove test file if it exists
if (Test-Path $TestFile) {
    Remove-Item -Path $TestFile -Force
    Write-Output ""
    Write-Output "Cleanup: Test file removed"
}

# Key Concepts:
# - SupportsShouldProcess adds -WhatIf and -Confirm to your function automatically
# - ConfirmImpact="High" means -Confirm is auto-triggered for important operations
# - Always wrap destructive operations in: if ($PSCmdlet.ShouldProcess(...)) { }
# - ShouldProcess has three overloads for different levels of message control
# - The function doesn't execute the destructive code if -WhatIf is specified
# - This follows PowerShell conventions and user expectations for safe scripting
