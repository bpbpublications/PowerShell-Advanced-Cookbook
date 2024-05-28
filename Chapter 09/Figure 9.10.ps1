# Delete AD User using -Identity parameter
Remove-ADUser -Identity "meh"

# Delete AD user using Get-ADuser and Pipe
Get-ADUser "meh" | Remove-ADUser

# Delete AD User without confirmation prompt
Remove-ADUser -Identity "meh" -Confirm:$false

# Checking the AD users Enabled state after removal
Get-ADUser meh