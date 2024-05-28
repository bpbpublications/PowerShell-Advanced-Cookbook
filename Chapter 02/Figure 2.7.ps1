function Add-Superhero {
    [CmdletBinding()]
    param (
          [Parameter(Position=0,Mandatory=$true)]
          [ValidateNotNullOrEmpty()]
          [String]$Name,
          [Parameter(Position=1)]
          [ValidateSet("Flying","Indestructable","LaserEyes")]
          [String[]]$Abilities = "None",
          [Parameter(Position=2,Mandatory=$false)]
          [ValidateRange(0,100)]
          [Int]$Powers = 10
          
    )

    $Object = [PSCustomObject]@{
        Abilities = $Abilities
        Name = $Name
        Powers = $Powers
    }
    Write-Verbose "Created Superhero with the name: $Name"
    Write-Verbose "$Name was given the following abilities: $Abilities"
    Write-Verbose "$Name has a power of: $Powers"

    return $Object

}

$Comet = Add-Superhero -Name Comet -Powers 43 -Abilities Flying,LaserEyes -Verbose
$Comet.Powers = 50
$Comet.Abilities += "Indestructable"
$Comet