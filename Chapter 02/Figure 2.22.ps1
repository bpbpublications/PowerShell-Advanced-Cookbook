# Figure 2.22 - Importing CSV data through pipeline with property binding
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates a real-world scenario: importing superhero data from CSV
# and processing each row through ValueFromPipelineByPropertyName.

function Add-Superhero {
    [CmdletBinding()]
    param (
        # Each parameter matches a CSV column name
        # ValueFromPipelineByPropertyName auto-binds CSV columns to parameters
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

    # ========================================================================
    # BEGIN BLOCK - Initialize collection before processing
    # ========================================================================

    Begin {
        $Superheroes = @{}
        Write-Verbose "Starting superhero import..."
    }

    # ========================================================================
    # PROCESS BLOCK - Runs once per CSV row
    # ========================================================================

    Process {
        # Apply alignment-based modifiers
        switch ($Alignment) {
            "Hero" {
                $Luck += 5
                $Greed -= 5
            }
            "Villain" {
                $Luck -= 5
                $Greed += 5
            }
            Default {
                $Luck += 3
                $Greed += 3
            }
        }

        # Create superhero object
        # Note: Abilities comes as comma-separated string from CSV, so we split it
        $Object = [PSCustomObject]@{
            Name      = $Name
            Alignment = $Alignment
            Abilities = $Abilities -split ","  # Split "Flying,Super Strength" into array
            Strength  = $Strength
            Armor     = $Armor
            Luck      = $Luck
            Greed     = $Greed
        }

        # Add to collection keyed by name
        $Superheroes[$Name] = $Object

        Write-Verbose "Created Superhero with the name: $Name"
        Write-Verbose "$Name is a $Alignment"
        Write-Verbose "$Name was given the following abilities: $Abilities"
        Write-Verbose "$Name has Strength: $Strength, Armor: $Armor, Luck: $Luck, Greed: $Greed"
    }

    # ========================================================================
    # END BLOCK - Return complete collection
    # ========================================================================

    End {
        Write-Verbose "Import complete. Total superheroes: $($Superheroes.Count)"
        return $Superheroes
    }
}

# ============================================================================
# IMPORT DATA FROM CSV
# ============================================================================

Write-Output "=== Importing Superheroes from CSV ==="

# The CSV file (Figure_2.21_HeroMap.csv) has columns:
# Name;Alignment;Abilities;Strength;Armor;Luck;Greed
#
# Using semicolon delimiter (common in European CSV files)
$Data = Import-Csv -Path .\Figure_2.21_HeroMap.csv -Delimiter ";"

# Pipeline flows each CSV row through Add-Superhero
# ValueFromPipelineByPropertyName binds each column to matching parameter
$Heroes = $Data | Add-Superhero -Verbose

# ============================================================================
# VIEW RESULTS
# ============================================================================

Write-Output ""
Write-Output "=== Imported Heroes ==="
$Heroes

# Expected Output:
# Name                           Value
# ----                           -----
# Comet                          @{Name=Comet; Alignment=Hero; Abilities=System.Object[]; ...}
# Blue Ghost                     @{Name=Blue Ghost; Alignment=Neutral; ...}
# Evilin                         @{Name=Evilin; Alignment=Villain; ...}

Write-Output ""
Write-Output "=== Individual Hero Details ==="
$Heroes["Comet"]

# Expected Output:
# Name      : Comet
# Alignment : Hero
# Abilities : {Flying, Super Strength, Invulnerability}
# Strength  : 80
# Armor     : 90
# Luck      : 45  (40 + 5 hero bonus)
# Greed     : 0   (5 - 5 hero penalty)

# Key Concepts:
# - CSV columns automatically bind to parameters with ValueFromPipelineByPropertyName
# - Import-Csv converts each row to a PSObject with properties named after columns
# - The -Delimiter parameter handles non-standard CSV formats (like semicolon-separated)
# - Abilities string "Flying,Super Strength" is split into an array
# - This pattern is powerful for bulk data import and processing
