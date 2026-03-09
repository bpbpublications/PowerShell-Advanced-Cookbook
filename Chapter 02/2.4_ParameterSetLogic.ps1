# Parameter Set Logic - Code Snippet
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications
#
# This snippet shows how to handle different parameter sets
# in the function body using $PSCmdlet.ParameterSetName.

# ============================================================================
# PARAMETER SET HANDLING TEMPLATE
# ============================================================================

# $PSCmdlet.ParameterSetName contains the name of the active parameter set
if ($PSCmdlet.ParameterSetName -eq "Hero") {
    # Hero parameter set was used
    $Alignment = "Hero"
    $AllAbilities = $Abilities + $HeroAbilities
    $Luck += 5    # Heroes get luck bonus
    $Greed -= 5   # Heroes are selfless
}
elseif ($PSCmdlet.ParameterSetName -eq "Villain") {
    # Villain parameter set was used
    $Alignment = "Villain"
    $AllAbilities = $Abilities + $VillainAbilities
    $Luck -= 5    # Villains have bad karma
    $Greed += 5   # Villains are greedy
}
else {
    # Default/Neutral parameter set
    $Alignment = "Neutral"
    $AllAbilities = $Abilities
    $Luck += 2    # Neutrals get modest bonuses
    $Greed += 2
}

# Key Concepts:
# - $PSCmdlet.ParameterSetName is set automatically during parameter binding
# - Use it to determine which mutually exclusive path to take
# - The else branch handles the default parameter set
# - This pattern is essential when parameter sets have different behaviors
