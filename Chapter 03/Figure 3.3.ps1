:OuterLoop foreach ($Outer in 1..3) {
    Write-Host "Outer Loop: $Outer"
    :InnerLoop foreach ($Inner in 1..3) {
        Write-Host "Inner Loop: $Inner"

        if ($Outer -eq 2 -and $Inner -eq 2) {
            Write-Host "Breaking out of the inner loop..."
            break InnerLoop
        }
    }
}


