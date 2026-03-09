# Figure 2.25 - ShouldProcess with -WhatIf for safe removal operations
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates implementing ShouldProcess in a real function that
# modifies data, using -WhatIf to preview changes without executing them.

# ============================================================================
# REMOVE-SUPERHERO FUNCTION WITH SHOULDPROCESS
# ============================================================================

function Remove-Superhero {
    # SupportsShouldProcess enables -WhatIf and -Confirm
    # ConfirmImpact="High" auto-prompts for confirmation on destructive operations
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        # ValueFromPipeline allows: "Comet","Evilin" | Remove-Superhero
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [String[]]$Name,

        # Name of the variable containing the heroes hashtable
        [Parameter(Position = 1)]
        [String]$HeroesVariable = "Heroes"
    )

    # ========================================================================
    # BEGIN BLOCK - Validate and get the heroes collection
    # ========================================================================

    Begin {
        # Check if the global variable exists
        if (-not (Get-Variable -Name $HeroesVariable -Scope Global -ErrorAction SilentlyContinue)) {
            throw "Global variable '$HeroesVariable' not found."
        }

        # Get reference to the global hashtable
        $Heroes = Get-Variable -Name $HeroesVariable -Scope Global -ValueOnly
        $Changes = $false
    }

    # ========================================================================
    # PROCESS BLOCK - Handle each name in the pipeline
    # ========================================================================

    Process {
        # Check if hero exists before attempting removal
        if (-not $Heroes.ContainsKey("$Name")) {
            Write-Verbose "$HeroesVariable does not contain a Superhero named: $Name"
            return
        }

        # ShouldProcess returns $true if we should proceed
        # With -WhatIf: Shows what would happen and returns $false
        # Without -WhatIf: Returns $true and allows the operation
        elseif ($PSCmdlet.ShouldProcess("$Name")) {
            $Heroes.Remove("$Name")
            Write-Verbose "Superhero: $Name removed"
            $Changes = $true
        }
    }

    # ========================================================================
    # END BLOCK - Report summary of changes
    # ========================================================================

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
# LOAD TEST DATA AND DEMONSTRATE -WHATIF
# ============================================================================

Write-Output "=== Loading Heroes from CSV ==="
$Data = Import-Csv -Path .\Figure_2.21_HeroMap.csv -Delimiter ";"
$global:Heroes = $Data | Add-Superhero -Verbose
$Heroes

# Expected Output:
# Name                           Value
# ----                           -----
# Comet                          @{Name=Comet; Alignment=Hero; ...}
# Blue Ghost                     @{Name=Blue Ghost; Alignment=Neutral; ...}
# Evilin                         @{Name=Evilin; Alignment=Villain; ...}

Write-Output ""
Write-Output "=== Testing Remove-Superhero with -WhatIf ==="

# -WhatIf shows what WOULD happen without actually removing
Remove-Superhero -Name Evilin -HeroesVariable Heroes -Verbose -WhatIf

# Expected Output:
# What if: Performing the operation "Remove-Superhero" on target "Evilin".
# VERBOSE: No changes were made to global variable: Heroes

Write-Output ""
Write-Output "=== Heroes collection UNCHANGED after -WhatIf ==="
$Heroes.Keys

# Expected Output (Evilin still exists!):
# Comet
# Blue Ghost
# Evilin

# Key Concepts:
# - -WhatIf previews the operation without executing it
# - ShouldProcess returns $false when -WhatIf is specified
# - This allows safe testing of destructive operations
# - Always implement ShouldProcess for functions that modify data
