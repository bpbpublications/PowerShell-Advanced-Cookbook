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
            { $this.Strength -eq 0} { $this.Strength = 10 }
            { $this.Armor -eq 0} { $this.Armor = 10 }
            { $this.Luck -eq 0} { $this.Luck = 5 }
            { $this.Greed -eq 0} { $this.Greed = 5 }
            { $this.Level -eq 0} { $this.Level = 1}
            { $this.Alignment -eq ""} { $this.Alignment = "Neutral"}
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

    [void] LevelUp() {
        $this.Level ++
    }

    [void] LevelDown() {
        $this.Level --
    }

    [void] Fly() {
        if ("Flying" -in $this.Abilities){
            if ($this.Flying){
                Write-Host "Superhero $($this.name) is already flying"
            }
            else{
                Write-Host "Superhero $($this.name) starts to fly"
                $this.Flying = $true
            }
        }
        else{
            Write-Host "Superhero $($this.Name) does not have the ability to fly"
        }
    }

    [Bool] IsFlying() {
        if ("Flying" -in $this.Abilities){
            if ($this.Flying){
                Write-Host "Superhero $($this.name) is flying"
                
            }
            else{
                Write-Host "Superhero $($this.name) is not flying"
                
            }
            
        }
        else{
            Write-Host "Superhero $($this.Name) does not have the ability to fly"
            
        }
        return $this.Flying
    }

    [void] StopFlying() {
        if ("Flying" -in $this.Abilities){
            if ($this.Flying){
                Write-Host "Superhero $($this.name) stops flying"
                $this.Flying = $false
            }
            else{
                Write-Host "Superhero $($this.name) is not flying"
                
            }
        }
        else{
            Write-Host "Superhero $($this.Name) does not have the ability to fly"
        }
    }
}

function Wrapper-CsvImport {
    [CmdletBinding()]
    param (
        [Parameter(Position=0,Mandatory=$true)]
        [String]$InputPath,
        [String]$Delimiter = ";"
    )

    $Superheroes = @{}

    $CsvFile = Import-Csv -Path $InputPath -Delimiter $Delimiter
    foreach ($Item in $CsvFile){
        
        $Superheroes[$Item.Name] = [NewSuperhero]::new(
        $Item.Name, 
        $Item.Alignment,
        $Item.Abilities -split ",",
        $Item.Strength,
        $Item.Armor,
        $Item.Luck,
        $Item.Greed,
        $Item.Level)
    }

    Return $Superheroes

}

$Superheroes = Wrapper-CsvImport -InputPath .\HeroMap2.csv

# Load the Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create the main form
$Form = New-Object Windows.Forms.Form
$Form.Text = "Superhero Abilities"
$Form.Size = New-Object Drawing.Size(400, 300)

# Create a TextBox control to display output
$OutputTextBox = New-Object Windows.Forms.TextBox
$OutputTextBox.Multiline = $true
$OutputTextBox.ReadOnly = $true
$OutputTextBox.ScrollBars = "Vertical"
$OutputTextBox.Dock = "Fill"

# Create a Button control
$Button = New-Object Windows.Forms.Button
$Button.Text = "Click Me"
$Button.Dock = "Bottom"

# Create the event handler script block
$EventHandler = {
    # Append output to the TextBox when the button is clicked
    $Superhero = $Superheroes.Values | Get-Random
    $Name = $Superhero.Name
    $Ability = Get-Random -InputObject ($Superhero.Abilities)
    $Alignment = $Superhero.Alignment
    $OutputTextBox.AppendText("$Alignment $Name using $Ability`r`n")
}

# Add a Click event handler to the button
$Button.Add_Click($EventHandler)

# Add controls to the form
$Form.Controls.Add($OutputTextBox)
$Form.Controls.Add($Button)

# Show the form
$Form.ShowDialog()