# using Job state to determine error

$Block = {
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

$Job = Start-Job -ScriptBlock $Block
Wait-Job $Job | Out-Null

if ($Job.State -eq "Failed") {
    Write-Error "Job $($Job.state) $($Job.ChildJobs[0].JobStateInfo.Reason.Message)."
} else {
    Write-Output "Job $($Job.State)."
}

Receive-Job $Job -ErrorAction SilentlyContinue