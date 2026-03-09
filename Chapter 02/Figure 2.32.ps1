# Figure 2.32 - PowerShell Classes: Wrapper function for CSV import
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates creating a wrapper function that imports CSV data
# and creates class instances, combining functions and classes together.

# ============================================================================
# CLASS DEFINITION
# ============================================================================

class NewSuperhero {
    [String] $Name
    [String] $Alignment
    [String[]] $Abilities
    [Int] $Strength
    [Int] $Armor
    [Int] $Luck
    [Int] $Greed
    [Int] $Level

    NewSuperhero(
        [String]$Name,
        [String]$Alignment,
        [String[]]$Abilities,
        [Int]$Strength,
        [Int]$Armor,
        [Int]$Luck,
        [Int]$Greed,
        [Int]$Level
    ) {
        $this.Name = $Name
        $this.Alignment = $Alignment
        $this.Abilities = $Abilities
        $this.Strength = $Strength
        $this.Armor = $Armor
        $this.Luck = $Luck
        $this.Greed = $Greed
        $this.Level = $Level

        $this.AddDefaultPropertyValues()
        $this.AdjustBehavior()
    }

    [void] AddDefaultPropertyValues() {
        switch ($null) {
            { $this.Strength -eq 0 }   { $this.Strength = 10 }
            { $this.Armor -eq 0 }      { $this.Armor = 10 }
            { $this.Luck -eq 0 }       { $this.Luck = 5 }
            { $this.Greed -eq 0 }      { $this.Greed = 5 }
            { $this.Level -eq 0 }      { $this.Level = 1 }
            { $this.Alignment -eq "" } { $this.Alignment = "Neutral" }
        }
    }

    [void] AdjustBehavior() {
        switch ($this.Alignment) {
            "Hero"    { $this.Luck += 5; $this.Greed -= 5 }
            "Villain" { $this.Luck -= 5; $this.Greed += 5 }
            Default   { $this.Luck += 3; $this.Greed += 3 }
        }
    }
}

# ============================================================================
# WRAPPER FUNCTION FOR CSV IMPORT
# ============================================================================

function Import-SuperheroesFromCsv {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [String]$InputPath,

        [String]$Delimiter = ";"
    )

    # Initialize collection
    $Superheroes = @{}

    # Import CSV file
    $CsvFile = Import-Csv -Path $InputPath -Delimiter $Delimiter

    # Create class instance for each row
    foreach ($Item in $CsvFile) {
        $Superheroes[$Item.Name] = [NewSuperhero]::new(
            $Item.Name,
            $Item.Alignment,
            ($Item.Abilities -split ","),  # Split comma-separated abilities
            $Item.Strength,
            $Item.Armor,
            $Item.Luck,
            $Item.Greed,
            $Item.Level
        )
    }

    return $Superheroes
}

# ============================================================================
# IMPORT AND USE
# ============================================================================

Write-Output "=== Importing Superheroes from CSV ==="

# Note: Using HeroMap.csv which has Level column
# If using Figure_2.21_HeroMap.csv, add Level column or modify class
$Heroes = Import-SuperheroesFromCsv -InputPath .\HeroMap.csv

Write-Output ""
Write-Output "=== All Heroes ==="
$Heroes

Write-Output ""
Write-Output "=== Access Individual Hero ==="
$Heroes.Evilin

# Expected Output for Evilin:
# Name      : Evilin
# Alignment : Villain
# Abilities : {Necromancy, Mind Control}
# Strength  : 35
# Armor     : 40
# Luck      : 5   (10 base - 5 villain penalty)
# Greed     : 31  (26 base + 5 villain bonus)
# Level     : 1

# ============================================================================
# MODIFYING CLASS INSTANCE PROPERTIES
# ============================================================================

Write-Output ""
Write-Output "=== Modifying Properties ==="

# Class instances are mutable - you can change properties
$Heroes.Evilin.Level = 2
$Heroes.Evilin

# Key Concepts:
# - Wrapper functions combine Import-Csv with class instantiation
# - Class instances are strongly-typed objects with consistent structure
# - Hashtables provide fast lookup by name: $Heroes.Evilin or $Heroes["Evilin"]
# - Properties of class instances can be modified after creation
# - This pattern separates data loading from object construction
