# Recipe 2.7: Implementing ShouldProcess
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates implementing -WhatIf and -Confirm support
# in functions that perform destructive operations.

# ============================================================================
# REMOVE-SUPERHERO: ShouldProcess for collection modification
# ============================================================================

function Remove-Superhero {
    # SupportsShouldProcess adds -WhatIf and -Confirm parameters
    # ConfirmImpact="High" auto-prompts for dangerous operations
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [String[]]$Name,

        [Parameter(Position = 1)]
        [String]$HeroesVariable = "Heroes"
    )

    Begin {
        # Verify the heroes collection exists
        if (-not (Get-Variable -Name $HeroesVariable -Scope Global -ErrorAction SilentlyContinue)) {
            throw "Global variable '$HeroesVariable' not found."
        }
        $Heroes = Get-Variable -Name $HeroesVariable -Scope Global -ValueOnly
        $Changes = $false
    }

    Process {
        if (-not $Heroes.ContainsKey("$Name")) {
            Write-Verbose "$HeroesVariable does not contain a Superhero named: $Name"
            return
        }
        # ShouldProcess returns $false with -WhatIf, or prompts with -Confirm
        elseif ($PSCmdlet.ShouldProcess("$Name")) {
            $Heroes.Remove("$Name")
            Write-Verbose "Superhero: $Name removed"
            $Changes = $true
        }
    }

    End {
        if ($Changes) {
            Write-Verbose "Removed Superheroes from: $HeroesVariable"
        }
        else {
            Write-Verbose "No changes were made to: $HeroesVariable"
        }
    }
}

# ============================================================================
# REMOVE-FILE: ShouldProcess overloads demonstration
# ============================================================================

function Remove-File {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$File
    )

    # Overload 1: ShouldProcess("Target")
    # Shows: "Performing the operation 'Remove-File' on target 'filename'"
    if ($PSCmdlet.ShouldProcess($File)) {
        Write-Output "Would execute: Remove-Item -Path $File"
        # Remove-Item -Path $File
    }

    # Overload 2: ShouldProcess("Target", "Action")
    # Shows: "Performing the operation 'Remove' on target 'filename'"
    if ($PSCmdlet.ShouldProcess($File, "Remove")) {
        Write-Output "Would execute: Remove-Item -Path $File"
        # Remove-Item -Path $File
    }

    # Overload 3: ShouldProcess("Message", "Target", "Action")
    # Full control over displayed message
    if ($PSCmdlet.ShouldProcess("Deleting file permanently", $File, "Remove")) {
        Write-Output "Would execute: Remove-Item -Path $File"
        # Remove-Item -Path $File
    }
}

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

Write-Output "=== Testing Remove-File with -WhatIf ==="
Remove-File -File "TestFile.txt" -WhatIf

# Expected Output:
# What if: Performing the operation "Remove-File" on target "TestFile.txt".
# What if: Performing the operation "Remove" on target "TestFile.txt".
# What if: Performing the operation "Remove" on target "TestFile.txt".

# Key Concepts:
# - SupportsShouldProcess adds -WhatIf and -Confirm automatically
# - Wrap destructive code in: if ($PSCmdlet.ShouldProcess(...)) { }
# - Three overloads for different message formats
# - ConfirmImpact determines when confirmation is automatic
