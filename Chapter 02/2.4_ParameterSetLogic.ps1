if ($PSCmdlet.ParameterSetName -eq "Hero"){
    $Alignment = "Hero"
    $AllAbilities = $Abilities + $HeroAbilities
    $Luck += 5
    $Greed -= 5
}
elseif ($PSCmdlet.ParameterSetName -eq "Villain") {
    $Alignment = "Villain"
    $AllAbilities = $Abilities + $VillainAbilities
    $Luck -= 5
    $Greed += 5
}
else{
    $Alignment = "Neutral"
    $AllAbilities = $Abilities
    $Luck +=2
    $Greed += 2
}

