# Disable AD user using -Identity parameter
Disable-ADAccount -Identity "meh"

# Disable AD user using Get-ADuser and Pipe
Get-ADUser "meh" | Disable-ADAccount

# Disable AD user using Set-ADUser and the -Enabled parameter
Set-ADUser -Identity "meh" -Enabled $false


# Checking the AD users Enabled state after disabling
Get-ADUser meh