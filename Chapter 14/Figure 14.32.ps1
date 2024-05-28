# View scheduled tasks object components for a specific scheduled task

# Store scheduled task in a variable
$Task = Get-ScheduledTask -TaskName "Advanced Task" | Select-Object *
# View the task actions
$Task.Actions
# View the task Principal
$Task.Principal
# View the task Settings
$Task.Settings
# View the task triggers
$Task.Triggers 
