# Figure 3.17 - Script blocks as Windows Forms event handlers
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications
# Platform: Windows only (uses Windows Forms)

# This example demonstrates using script blocks as event handlers for
# GUI applications. Script blocks enable dynamic response to user
# interactions like button clicks, providing the "glue" between UI
# and business logic.

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
# WINDOWS FORMS GUI SETUP
# ============================================================================

# Load the Windows Forms assembly - required for GUI elements
Add-Type -AssemblyName System.Windows.Forms

# Create the main application window
$Form = New-Object Windows.Forms.Form
$Form.Text = "Superhero Abilities"    # Window title
$Form.Size = New-Object Drawing.Size(400, 300)

# Create a multi-line TextBox to display output
$OutputTextBox = New-Object Windows.Forms.TextBox
$OutputTextBox.Multiline = $true       # Allow multiple lines
$OutputTextBox.ReadOnly = $true        # User can't edit the output
$OutputTextBox.ScrollBars = "Vertical" # Add scrollbar for long output
$OutputTextBox.Dock = "Fill"           # Fill available space

# Create a Button control
$Button = New-Object Windows.Forms.Button
$Button.Text = "Click Me"
$Button.Dock = "Bottom"                # Position at bottom of form

# ============================================================================
# EVENT HANDLER SCRIPT BLOCK
# ============================================================================

# This script block executes when the button is clicked
# It demonstrates how script blocks integrate with .NET events
$EventHandler = {
    # Select a random superhero from the collection
    $Superhero = $Superheroes.Values | Get-Random

    # Extract properties for display
    $Name = $Superhero.Name
    $Ability = Get-Random -InputObject ($Superhero.Abilities)
    $Alignment = $Superhero.Alignment

    # Append the action to the TextBox (with carriage return for new line)
    $OutputTextBox.AppendText("$Alignment $Name using $Ability`r`n")
}

# ============================================================================
# CONNECT EVENT HANDLER TO BUTTON
# ============================================================================

# Add_Click is an auto-generated method for the Click event
# The script block will execute each time the button is clicked
$Button.Add_Click($EventHandler)

# ============================================================================
# ADD CONTROLS AND SHOW FORM
# ============================================================================

# Add controls to the form's control collection
$Form.Controls.Add($OutputTextBox)
$Form.Controls.Add($Button)

# ShowDialog() displays the form modally (blocks until closed)
$Form.ShowDialog()

# ============================================================================
# KEY CONCEPTS DEMONSTRATED
# ============================================================================
# - Add-Type loads .NET assemblies (System.Windows.Forms)
# - Script blocks serve as event handlers for GUI events
# - Add_<EventName> pattern connects handlers to events
# - Script blocks have access to variables in their defining scope
#   ($Superheroes, $OutputTextBox are accessible inside $EventHandler)
# - This is called "closure" - the script block "closes over" outer variables
# - ShowDialog() runs the form in modal mode

# Expected Behavior:
# - A window appears with a text box and button
# - Each button click adds a line like:
#   "Hero Tornado Tim using Pyrokinesis"
#   "Villain Chiss using Telepathy"
# - Random superhero and ability selected each time

# ============================================================================
# COMMON WINDOWS FORMS EVENTS
# ============================================================================
# Add_Click      - Button/control clicked
# Add_Load       - Form loaded
# Add_FormClosed - Form closed
# Add_KeyDown    - Key pressed
# Add_MouseMove  - Mouse moved over control
