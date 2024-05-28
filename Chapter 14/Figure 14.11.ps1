"Start $(Get-Date)"
Start-Process Notepad
$Proc = Get-Process Notepad

Start-Job -ScriptBlock{
    param($ProcId)

    Start-Sleep -Seconds 15
    Stop-Process -Id $ProcId
} -ArgumentList $Proc.Id | Out-Null

Wait-Process $Proc.Id
"Stop $(Get-Date)"