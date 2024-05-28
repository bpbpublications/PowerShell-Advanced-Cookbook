$Block = {
    $Files = @("File1.txt","File2.txt","NonExistingFile.txt","File3.txt")
    foreach ($File in $Files){
        $Data = [PSCustomObject]@{
            Date = Get-Date -f "dd-MM-yyyy HH:mm:ss"
            ErrorLevel = ""
            Message = ""
        }
        try {
            $Content = Get-Content -Path $File -ErrorAction Stop
            $Data.Message = "Content from $($File) successfully logged: $($Content)"
            $Data.ErrorLevel = "Info"
        } catch {
            $Data.Message = "Failed to load content from $($File): $_"
            $Data.ErrorLevel = "Error"
        }
        
        $Data | ConvertTo-Json -Compress | Out-File -FilePath "C:\temp\ErrorLog.json" -Append
        $Data
    }
}

$Job = Start-Job -ScriptBlock $Block

Wait-Job $Job | Out-Null

Receive-Job $Job
$JobResults