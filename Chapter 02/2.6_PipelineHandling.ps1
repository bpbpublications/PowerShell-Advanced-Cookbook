# Recipe 2.6: Pipeline Handling
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates importing CSV data through a pipeline
# and processing each row with ValueFromPipelineByPropertyName.

function Add-Superhero {
    [CmdletBinding()]
    param (
        # Each parameter matches a CSV column name
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

    Begin {
        $Superheroes = @{}
        Write-Verbose "Starting pipeline processing..."
    }

    Process {
        # Apply alignment-based modifiers
        switch ($Alignment) {
            "Hero"    { $Luck += 5; $Greed -= 5 }
            "Villain" { $Luck -= 5; $Greed += 5 }
            Default   { $Luck += 3; $Greed += 3 }
        }

        # Create superhero object
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
        Write-Verbose "Abilities: $Abilities"
        Write-Verbose "Stats - Strength: $Strength, Armor: $Armor, Luck: $Luck, Greed: $Greed"
    }

    End {
        Write-Verbose "Processed $($Superheroes.Count) superheroes"
        return $Superheroes
    }
}

# ============================================================================
# IMPORT FROM CSV
# ============================================================================

Write-Output "=== Importing Superheroes from CSV ==="

# Import-Csv creates objects where each column becomes a property
# ValueFromPipelineByPropertyName automatically binds matching columns
$Data = Import-Csv -Path .\HeroMap.csv -Delimiter ";"
$Heroes = $Data | Add-Superhero -Verbose

Write-Output ""
Write-Output "=== Imported Heroes ==="
$Heroes

# Key Concepts:
# - CSV column names become property names on imported objects
# - ValueFromPipelineByPropertyName automatically binds matching properties
# - Process block runs once per CSV row
# - This pattern is perfect for bulk data import scenarios
