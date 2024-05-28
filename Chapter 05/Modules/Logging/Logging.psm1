# Make sure to get the path where the module is placed
$ScriptRoot = Split-Path $Script:MyInvocation.MyCommand.Path

# Pull in Private files
Get-ChildItem "$ScriptRoot\Private" *.ps1 | ForEach-Object { Import-Module $_.FullName}

# Pull in Public files
Get-ChildItem "$ScriptRoot\Public" *.ps1 | ForEach-Object { Import-Module $_.FullName}