# Recipe: Create and Use Script Blocks for Dynamic Flow Control
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates how script blocks enable dynamic, flexible
# control flow by treating executable code as data that can be stored,
# passed to functions, and executed on demand.

# ============================================================================
# SUPERHERO CLASS DEFINITION
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
    [bool] $Flying

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
        $this.Flying = $false
    }

    [void] AddDefaultPropertyValues() {
        switch ($null) {
            { $this.Strength -eq 0 } { $this.Strength = 10 }
            { $this.Armor -eq 0 } { $this.Armor = 10 }
            { $this.Luck -eq 0 } { $this.Luck = 5 }
            { $this.Greed -eq 0 } { $this.Greed = 5 }
            { $this.Level -eq 0 } { $this.Level = 1 }
            { $this.Alignment -eq "" } { $this.Alignment = "Neutral" }
        }
    }

    [void] AdjustBehavior() {
        switch ($this.Alignment) {
            "Superhero" {
                $this.Luck += 5
                $this.Greed -= 5
            }
            "Villain" {
                $this.Luck -= 5
                $this.Greed += 5
            }
            Default {
                $this.Luck += 3
                $this.Greed += 3
            }
        }
    }

    [void] LevelUp() { $this.Level++ }
    [void] LevelDown() { $this.Level-- }

    [void] Fly() {
        if ("Flying" -in $this.Abilities) {
            if ($this.Flying) {
                Write-Host "Superhero $($this.Name) is already flying"
            }
            else {
                Write-Host "Superhero $($this.Name) starts to fly"
                $this.Flying = $true
            }
        }
        else {
            Write-Host "Superhero $($this.Name) does not have the ability to fly"
        }
    }

    [Bool] IsFlying() {
        if ("Flying" -in $this.Abilities) {
            if ($this.Flying) {
                Write-Host "Superhero $($this.Name) is flying"
            }
            else {
                Write-Host "Superhero $($this.Name) is not flying"
            }
        }
        else {
            Write-Host "Superhero $($this.Name) does not have the ability to fly"
        }
        return $this.Flying
    }

    [void] StopFlying() {
        if ("Flying" -in $this.Abilities) {
            if ($this.Flying) {
                Write-Host "Superhero $($this.Name) stops flying"
                $this.Flying = $false
            }
            else {
                Write-Host "Superhero $($this.Name) is not flying"
            }
        }
        else {
            Write-Host "Superhero $($this.Name) does not have the ability to fly"
        }
    }
}

# ============================================================================
# CSV IMPORT WRAPPER
# ============================================================================

function Wrapper-CsvImport {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [String]$InputPath,
        [String]$Delimiter = ";"
    )

    $Superheroes = @{}
    $CsvFile = Import-Csv -Path $InputPath -Delimiter $Delimiter

    foreach ($Item in $CsvFile) {
        $Superheroes[$Item.Name] = [NewSuperhero]::new(
            $Item.Name,
            $Item.Alignment,
            $Item.Abilities -split ",",
            $Item.Strength,
            $Item.Armor,
            $Item.Luck,
            $Item.Greed,
            $Item.Level
        )
    }

    return $Superheroes
}

$Superheroes = Wrapper-CsvImport -InputPath .\HeroMap2.csv

# ============================================================================
# SCRIPT BLOCKS AS FILTERS (WHERE-OBJECT PATTERN)
# ============================================================================

# Script blocks can be stored and reused with Where-Object
# This creates a reusable filter for high-level characters
$HighLevelFilter = {
    $_.Level -ge 25
}

# Apply the filter to get high-level superheroes
$HighLevelSuperheroes = $Superheroes.Values | Where-Object $HighLevelFilter
$HighLevelSuperheroes.Name

# ============================================================================
# SCRIPT BLOCKS WITH PARAMETERS (CUSTOM LOGIC)
# ============================================================================

# Script blocks can accept parameters using param()
# This creates a more flexible filter with custom logic
$HighLevelFilter = {
    param($Superhero)
    if ($Superhero.Level -gt 20) {
        return $Superhero.Name
    }
}

# Execute the script block for each superhero using & (call operator)
$FilteredSuperheroes = $Superheroes.Values | ForEach-Object { & $HighLevelFilter $_ }
$FilteredSuperheroes

# ============================================================================
# SCRIPT BLOCKS AS CALLBACKS (FUNCTION INJECTION)
# ============================================================================

# Functions can accept script blocks as parameters, enabling
# "plug-in" behavior where the caller defines the action
function Invoke-Ability {
    param (
        [scriptblock]$Callback
    )

    # The & operator executes the script block, passing an argument
    & $Callback $Superheroes."Atmos Fear"
}

# Define different callbacks for different behaviors
$MyCallback = {
    param($Superhero)
    Write-Output "$($Superhero.Name) using ability $($Superhero.Abilities[0])"
}

$MyCallback2 = {
    param($Superhero)
    Write-Output "$($Superhero.Name) using ability $($Superhero.Abilities[1])"
}

# Same function, different behavior based on callback
Invoke-Ability -Callback $MyCallback
Invoke-Ability -Callback $MyCallback2

# ============================================================================
# SCRIPT BLOCKS AS EVENT HANDLERS (WINDOWS FORMS)
# ============================================================================
# Platform: Windows only

# Load Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create the main form
$Form = New-Object Windows.Forms.Form
$Form.Text = "Superhero Abilities"
$Form.Size = New-Object Drawing.Size(400, 300)

# Create output display
$OutputTextBox = New-Object Windows.Forms.TextBox
$OutputTextBox.Multiline = $true
$OutputTextBox.ReadOnly = $true
$OutputTextBox.ScrollBars = "Vertical"
$OutputTextBox.Dock = "Fill"

# Create action button
$Button = New-Object Windows.Forms.Button
$Button.Text = "Click Me"
$Button.Dock = "Bottom"

# EVENT HANDLER SCRIPT BLOCK
# This demonstrates closure - the script block captures $Superheroes
# and $OutputTextBox from the outer scope
$EventHandler = {
    # Select random superhero
    $Superhero = $Superheroes.Values | Get-Random

    # Extract display values
    $Name = $Superhero.Name
    $Ability = Get-Random -InputObject ($Superhero.Abilities)
    $Alignment = $Superhero.Alignment

    # Update the TextBox
    $OutputTextBox.AppendText("$Alignment $Name using $Ability`r`n")
}

# Connect handler to button click event
$Button.Add_Click($EventHandler)

# Assemble and display the form
$Form.Controls.Add($OutputTextBox)
$Form.Controls.Add($Button)
$Form.ShowDialog()

# ============================================================================
# KEY CONCEPTS SUMMARY
# ============================================================================

# 1. SCRIPT BLOCK BASICS:
#    - Defined with { } braces
#    - Can contain any PowerShell code
#    - Executed with & (call operator) or . (dot-source)

# 2. PARAMETERS:
#    - Use param() block at the start
#    - Or use automatic $args array
#    - Example: { param($x, $y) $x + $y }

# 3. CLOSURE:
#    - Script blocks capture variables from their defining scope
#    - Variables remain accessible even after scope exits
#    - Enables powerful patterns like event handlers

# 4. COMMON USES:
#    - Where-Object filters: { $_.Property -eq "Value" }
#    - ForEach-Object actions: { Do-Something $_ }
#    - Callbacks to functions: Invoke-Command { ... }
#    - Event handlers: $Button.Add_Click({ ... })
#    - Delayed execution: storing code for later

# 5. EXECUTION METHODS:
#    - & $ScriptBlock args  : Call operator (new scope)
#    - . $ScriptBlock args  : Dot-source (current scope)
#    - Invoke-Command -ScriptBlock $sb
#    - $ScriptBlock.Invoke(args)

# Expected Output:
# (High level superhero names)
# (Filtered superhero names)
# Atmos Fear using ability Telepathy
# Atmos Fear using ability Super Strength
# (GUI window with button - each click shows random superhero action)
