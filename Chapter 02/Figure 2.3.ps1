function SuperHero ($Name, $Ability) {
    "$Name is $Ability" | Out-File -FilePath C:\Temp\Superhero\Supeheroes.txt -Append | Out-Null
}

SuperHero -Name "Green Giant" -Ability "Smashing"
SuperHero -Name "Lightning Girl" -Ability "Creating thunder"



