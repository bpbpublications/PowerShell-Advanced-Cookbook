# View all session
Get-PSSession

# Remove a session
Remove-PSSession $Session

# View all session
Get-PSSession

# Try to invoke command on removed session
Invoke-Command -Session $Session -ScriptBlock {$ENV:COMPUTERNAME}