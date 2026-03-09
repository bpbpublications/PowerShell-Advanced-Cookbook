# Figure 2.27 - Pipeline-based removal with ShouldProcess
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates removing multiple items via pipeline,
# with ShouldProcess protecting each removal operation.

# ============================================================================
# REMOVE-SUPERHERO FUNCTION WITH SHOULDPROCESS
# ============================================================================

function Remove-Superhero {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        # ValueFromPipeline enables: "Name1","Name2" | Remove-Superhero
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
        $RemovedCount = 0
    }

    Process {
        # Process block runs once per pipeline item
        if (-not $Heroes.ContainsKey("$Name")) {
            Write-Verbose "$HeroesVariable does not contain a Superhero named: $Name"
            return
        }
        elseif ($PSCmdlet.ShouldProcess("$Name", "Remove from $HeroesVariable")) {
            $Heroes.Remove("$Name")
            Write-Verbose "Superhero: $Name removed"
            $Changes = $true
            $RemovedCount++
        }
    }

    End {
        if ($Changes) {
            Write-Verbose "Removed $RemovedCount superhero(es) from: $HeroesVariable"
            Write-Verbose "Remaining count: $($Heroes.Count)"
        }
        else {
            Write-Verbose "No changes were made to: $HeroesVariable"
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

Write-Output ""
Write-Output "=== Initial Heroes Collection ==="
$Heroes.Keys

# Expected Output:
# Comet
# Blue Ghost
# Evilin

# ============================================================================
# PIPELINE-BASED REMOVAL
# ============================================================================

Write-Output ""
Write-Output "=== Removing Multiple Heroes via Pipeline ==="

# Multiple names flow through the pipeline
# Process block runs once per name
# ShouldProcess protects each removal
"Comet", "Blue Ghost" | Remove-Superhero -Verbose

# Expected Output:
# VERBOSE: Superhero: Comet removed
# VERBOSE: Superhero: Blue Ghost removed
# VERBOSE: Removed 2 superhero(es) from: Heroes
# VERBOSE: Remaining count: 1

# ============================================================================
# VERIFY REMAINING HEROES
# ============================================================================

Write-Output ""
Write-Output "=== Remaining Heroes ==="
$Heroes

# Expected Output:
# Name                           Value
# ----                           -----
# Evilin                         @{Name=Evilin; Alignment=Villain; ...}

Write-Output ""
Write-Output "=== Heroes Count ==="
$Heroes.Count

# Expected Output: 1

# Key Concepts:
# - ValueFromPipeline allows piping multiple names: "A","B" | Remove-Superhero
# - Process block runs once per pipeline item
# - ShouldProcess protects each individual removal
# - End block can summarize all changes made during pipeline processing
# - This pattern is common in cmdlets that modify collections
