# Listing the scheduled tasks and all its properties after creation and registering

# creating and Registering a scheduled task

# Define the action
$Action = New-ScheduledTaskAction -Execute "powershell.exe" `
-Argument "-file C:\Scritps\Update.ps1" 

# Define the hourly trigger
$HourlyTrigger = New-ScheduledTaskTrigger `
-Once `
-At "10:00:00" `
-RepetitionInterval ([TimeSpan]::FromHours(1))

# Define the login trigger
$LoginTrigger = New-ScheduledTaskTrigger -AtLogon 

# Define settings
$Settings = New-ScheduledTaskSettingsSet -Priority 3 `
-ExecutionTimeLimit ([TimeSpan]::FromHours(1)) `
-MultipleInstances IgnoreNew 

# Define the principal
$Principal = New-ScheduledTaskPrincipal `
-RunLevel Highest `
-UserId "SYSTEM" `
-LogonType ServiceAccount 

# Create the scheduled task
$Task = New-ScheduledTask `
-Action $Action `
-Trigger $HourlyTrigger, $LoginTrigger `
-Settings $Settings `
-Principal $Principal `
-Description "Update Task" 

# Register the task
Register-ScheduledTask -TaskName "UpdateTask" `
-InputObject $Task `
-TaskPath "\CustomTasks\" `
-Force 

Get-ScheduledTask -TaskName "UpdateTask" | Select-Object *