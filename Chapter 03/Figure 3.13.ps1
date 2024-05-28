function Get-MemoryUsage{
    param(
        [scriptblock]$Block
    )

    $BeforeMemory = (Get-CimInstance WIN32_PROCESS | Where-Object {$_.ProcessID -eq $PID}).WorkingSetSize 
    & $Block
    $AfterMemory = (Get-CimInstance WIN32_PROCESS | Where-Object {$_.ProcessID -eq $PID}).WorkingSetSize 
    $MemoryUsed = $AfterMemory - $BeforeMemory

    Write-Output "Memory Usage: $($MemoryUsed/1MB) MB"

}

$VariableBlock = {
    $Count = 0
    $Data = Get-Content .\organizations-100000.csv
    foreach ($Item in $Data){
        $Count++
    }
}

$PipelinedBlock = {
    $Count = 0
    Get-Content .\organizations-100000.csv | ForEach-Object {$Count++}
}

Write-Output "VariableBlock:"
Get-MemoryUsage $VariableBlock
Write-Output "PipelinedBlock:"
Get-MemoryUsage $PipelinedBlock
