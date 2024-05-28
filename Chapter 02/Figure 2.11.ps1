$Object1 = [PSCustomObject]@{
    "Abilities" = $Abilities
    "Name" = $Name
    "Powers" = $Powers
 }


 $Object2 = @{
    "Abilities" = $Abilities
    "Name" = $Name
    "Powers" = $Powers
 }

 $Object1 | Get-Member

 $Object2 | Get-Member