# Figure 2.26 - ShouldProcess with -Confirm for interactive confirmation
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates using -Confirm to prompt for user approval
# before executing destructive operations.

# ============================================================================
# REMOVE-SUPERHERO FUNCTION WITH SHOULDPROCESS
# ============================================================================

function Remove-Superhero {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [String[]]$Name,

        [Parameter(Position = 1)]
        [String]$HeroesVariable = "Heroes"
    )

    Begin {
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
        # ShouldProcess with -Confirm will prompt the user
        elseif ($PSCmdlet.ShouldProcess("$Name")) {
            $Heroes.Remove("$Name")
            Write-Verbose "Superhero: $Name removed"
            $Changes = $true
        }
    }

    End {
        if ($Changes) {
            Write-Verbose "Removed Superheroes from global variable: $HeroesVariable"
        }
        else {
            Write-Verbose "No changes were made to global variable: $HeroesVariable"
        }
    }
}

# ============================================================================
# ADD-SUPERHERO FUNCTION (For loading test data)
# ============================================================================

function Add-Superhero {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [String]$Name,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)]
        [ValidateSet("Hero", "Villain", "Neutral")]
        [String]$Alignment,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName)]
        [String[]]$Abilities,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName)]
        [ValidateRange(0, 100)]
        [Int]$Strength = 10,
        [Parameter(Position = 4, ValueFromPipelineByPropertyName)]
        [ValidateRange(0, 100)]
        [Int]$Armor = 10,
        [Parameter(Position = 5, ValueFromPipelineByPropertyName)]
        [ValidateRange(0, 50)]
        [int]$Luck = 5,
        [Parameter(Position = 6, ValueFromPipelineByPropertyName)]
        [ValidateRange(0, 50)]
        [int]$Greed = 5
    )

    Begin { $Superheroes = @{} }

    Process {
        switch ($Alignment) {
            "Hero"    { $Luck += 5; $Greed -= 5 }
            "Villain" { $Luck -= 5; $Greed += 5 }
            Default   { $Luck += 3; $Greed += 3 }
        }

        $Object = [PSCustomObject]@{
            Name      = $Name
            Alignment = $Alignment
            Abilities = $Abilities -split ","
            Strength  = $Strength
            Armor     = $Armor
            Luck      = $Luck
            Greed     = $Greed
        }
        $Superheroes[$Name] = $Object
        Write-Verbose "Created Superhero: $Name ($Alignment)"
    }

    End { return $Superheroes }
}

# ============================================================================
# LOAD TEST DATA
# ============================================================================

Write-Output "=== Loading Heroes from CSV ==="
$Data = Import-Csv -Path .\Figure_2.21_HeroMap.csv -Delimiter ";"
$global:Heroes = $Data | Add-Superhero -Verbose
$Heroes

# ============================================================================
# DEMONSTRATE -CONFIRM BEHAVIOR
# ============================================================================

Write-Output ""
Write-Output "=== Testing Remove-Superhero with -Confirm ==="
Write-Output "Note: In interactive mode, this prompts for each removal"

# -Confirm prompts for approval before each operation
# User can respond:
#   Y - Yes (proceed with this item)
#   A - Yes to All (proceed with all remaining items)
#   N - No (skip this item)
#   L - No to All (skip all remaining items)
#   S - Suspend (drop to PowerShell prompt, type 'exit' to resume)

# Note: Commented out for non-interactive execution
# Remove-Superhero -Name Evilin -HeroesVariable Heroes -Verbose -Confirm

# Interactive prompt would show:
# Confirm
# Are you sure you want to perform this action?
# Performing the operation "Remove-Superhero" on target "Evilin".
# [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):

Write-Output ""
Write-Output "=== Current Heroes (unchanged in non-interactive mode) ==="
$Heroes

# Key Concepts:
# - -Confirm prompts for user approval before each action
# - With ConfirmImpact="High", confirmation is automatic for important operations
# - User has options: Yes, Yes to All, No, No to All, Suspend
# - This is essential for production scripts that modify critical data
# - Combine with -WhatIf to preview before confirming
