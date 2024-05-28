$job = Start-Job -ScriptBlock {
    $Files = @("File1.txt","File2.txt","NonExistingFile.txt","File3.txt")
    foreach ($File in $Files) {
        try {
            $Content = Get-Content -Path $File -ErrorAction Stop
            "Content from $($File) successfully extracted: $($Content)"
        } catch {
            "Failed to load content from $($File): $_"
            throw
        }
    }
}

Wait-Job $job | Out-Null

try {
    Receive-Job $job -ErrorAction Stop
} catch {
    Write-Error "Error occurred in the job: $_"
}